//
//  TLGPUImageMovie.h
//  TLStoryCamera
//
//  Created by garry on 2017/9/14.
//  Copyright © 2017年 com.garry. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface TLGPUImageMovie : GPUImageMovie
@property(nonatomic,copy)void (^startProcessingCallback)();
@end
