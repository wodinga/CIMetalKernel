//
//  FilterKernel.metal
//  MetalFilter
//
//  Created by David Garcia on 4/2/19.
//  Copyright © 2019 David Garcia. All rights reserved.
//

//#include <metal_stdlib>
#include <CoreImage/CoreImage.h>

extern "C" {
    namespace coreimage {
        float4 test(sampler src) {
            float4 pixValue; // 2
//            CoreImage ci = CoreImage();
            pixValue = src.sample(src.coord());
//            int num = 0;
            unpremultiply(pixValue); // 4
            pixValue.r = src.coord().x / src.extent().w;
            pixValue.g = src.coord().y / src.extent().z;
            
//            pixValue.r = 1.0 - pixValue.r; // 5
//            pixValue.g = 1.0 - pixValue.g;
//            pixValue.b = 1.0 - pixValue.b;
            return premultiply(pixValue);
//            return src
        }
    }
}
