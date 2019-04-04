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
            float4 pixValue;
            // Get current value
            pixValue = src.sample(src.coord());
            //Unmultiply alpha from RGB
            unpremultiply(pixValue);

            // Mess around with the color values to create a gradient
            pixValue.r = src.coord().x / src.extent().w;
            pixValue.g = src.coord().y / src.extent().z;

            return premultiply(pixValue);
        }
    }
}
