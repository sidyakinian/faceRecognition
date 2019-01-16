//
//  Functions.m
//  SourceFiles
//
//  Created by sidyakinian on 05/08/2018.
//  Copyright © 2018 sidyakinian. All rights reserved.
//

#import "Functions.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "Templates.hpp"
#include "dlib-ios.h"

#include <dlib/dnn.h>
#include <dlib/gui_widgets.h>
#include <dlib/clustering.h>
#include <dlib/string.h>
#include <dlib/image_io.h>
#include <dlib/image_processing.h>
#include <dlib/image_processing/generic_image.h>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_transforms.h>

// Explicit errors
#include <dlib/entropy_decoder/entropy_decoder_kernel_2.cpp>
#include <dlib/base64/base64_kernel_1.cpp>
#include <dlib/cuda/cpu_dlib.cpp>
#include <dlib/threads/thread_pool_extension.cpp>
#include <dlib/threads/async.cpp>
#include <dlib/cuda/tensor_tools.cpp>

using namespace std;

@implementation Functions

- (NSMutableArray*) getImageDescriptor:(UIImage*)image {
    dlib::frontal_face_detector detector = dlib::get_frontal_face_detector();
    
    dlib::shape_predictor predictor;
    NSString *modelFileName = [[NSBundle mainBundle] pathForResource: @"shape_predictor_5_face_landmarks" ofType: @"dat"];
    string modelFileNameCString = string([modelFileName UTF8String]);
    dlib::deserialize(modelFileNameCString) >> predictor;
    
    anet_type net;
    NSString *model2FileName = [[NSBundle mainBundle] pathForResource: @"dlib_face_recognition_resnet_model_v1" ofType: @"dat"];
    string model2FileNameCString = string([model2FileName UTF8String]);
    dlib::deserialize(model2FileNameCString) >> net;
    
//    cout << "UIImage to dlib started" << endl;
    
    dlib::array2d<dlib::bgr_pixel> img;
    UIImageToDlibImage(image, img);
    dlib::matrix<dlib::rgb_pixel> matrix;
    dlib::assign_image(matrix, img);
    vector<dlib::matrix<dlib::rgb_pixel>> faces;
    
//    cout << "Face detector started" << endl;
    
    for (auto face: detector(matrix))
    {
        auto shape = predictor(matrix, face);
        dlib::matrix<dlib::rgb_pixel> face_chip;
        extract_image_chip(matrix, get_face_chip_details(shape,150,0.25), face_chip);
        faces.push_back(move(face_chip));
        // Also put some boxes on the faces so we can see that the detector is finding
        // them.
    }
    
    if (faces.size() == 0)
    {
        cout << "No faces found in image!" << endl;
        NSMutableArray *zeroFaces = [NSMutableArray array];
        
        for (int i = 0; i < 1; i += 1)
            [zeroFaces addObject: [NSNumber numberWithInteger: i]];
        return zeroFaces;
    }
    
    // This call asks the DNN to convert each face image in faces into a 128D vector.
    // In this 128D vector space, images from the same person will be close to each other
    // but vectors from different people will be far apart.  So we can use these vectors to
    // identify if a pair of images are from the same person or from different people.
//    cout << "Face descriptors started" << endl;
    
    // Longest thing - takes a few seconds!
    std::vector<dlib::matrix<float,0,1>> face_descriptors = net(faces);
//    cout << "Face descriptors created!" << endl;
    
    // Clustering... (skipped)
    
//    cout << "Vector started!" << endl;
    vector<float> vector;
    for (int i = 0; i < 128; i += 1) {
        float iFloat = face_descriptors[0](i, 0);
        vector.push_back(iFloat);
    }
    
//    cout << "NSMutableArray started!" << endl;
    
    NSMutableArray *myIntegers = [NSMutableArray array];
    
    for (int i = 0; i < 128; i += 1)
        [myIntegers addObject: [NSNumber numberWithFloat: vector.at(i)]];
    
    return myIntegers;
}

@end
