// Run: %dxc -T ps_6_0 -E main

SamplerState gSampler : register(s1);

Texture2DArray   <float4> t2 : register(t2);
TextureCubeArray <uint3>  t4 : register(t4);
Texture2DArray   <int3>   t6 : register(t6);
TextureCubeArray <float>  t8 : register(t8);
// .Gather() does not support Texture1DArray.

// CHECK: OpCapability ImageGatherExtended

// CHECK: [[v4fc:%\d+]] = OpConstantComposite %v4float %float_0_1 %float_0_2 %float_0_3 %float_0_4

float4 main(float3 location: A, int2 offset: B) : SV_Target {

// CHECK:              [[t2:%\d+]] = OpLoad %type_2d_image_array %t2
// CHECK-NEXT:   [[gSampler:%\d+]] = OpLoad %type_sampler %gSampler
// CHECK-NEXT:        [[loc:%\d+]] = OpLoad %v3float %location
// CHECK-NEXT:     [[offset:%\d+]] = OpLoad %v2int %offset
// CHECK-NEXT: [[sampledImg:%\d+]] = OpSampledImage %type_sampled_image [[t2]] [[gSampler]]
// CHECK-NEXT:            {{%\d+}} = OpImageGather %v4float [[sampledImg]] [[loc]] %int_0 Offset [[offset]]
    float4 val2 = t2.Gather(gSampler, location, offset);

// CHECK:              [[t4:%\d+]] = OpLoad %type_cube_image_array %t4
// CHECK-NEXT:   [[gSampler:%\d+]] = OpLoad %type_sampler %gSampler
// CHECK-NEXT: [[sampledImg:%\d+]] = OpSampledImage %type_sampled_image_0 [[t4]] [[gSampler]]
// CHECK-NEXT:            {{%\d+}} = OpImageGather %v4uint [[sampledImg]] [[v4fc]] %int_0
    uint4 val4 = t4.Gather(gSampler, float4(0.1, 0.2, 0.3, 0.4));

// CHECK:              [[t6:%\d+]] = OpLoad %type_2d_image_array_0 %t6
// CHECK-NEXT:   [[gSampler:%\d+]] = OpLoad %type_sampler %gSampler
// CHECK-NEXT:        [[loc:%\d+]] = OpLoad %v3float %location
// CHECK-NEXT:     [[offset:%\d+]] = OpLoad %v2int %offset
// CHECK-NEXT: [[sampledImg:%\d+]] = OpSampledImage %type_sampled_image_1 [[t6]] [[gSampler]]
// CHECK-NEXT:            {{%\d+}} = OpImageGather %v4int [[sampledImg]] [[loc]] %int_0 Offset [[offset]]
    int4 val6 = t6.Gather(gSampler, location, offset);

// CHECK:              [[t8:%\d+]] = OpLoad %type_cube_image_array_0 %t8
// CHECK-NEXT:   [[gSampler:%\d+]] = OpLoad %type_sampler %gSampler
// CHECK-NEXT: [[sampledImg:%\d+]] = OpSampledImage %type_sampled_image_2 [[t8]] [[gSampler]]
// CHECK-NEXT:            {{%\d+}} = OpImageGather %v4float [[sampledImg]] [[v4fc]] %int_0
    float4 val8 = t8.Gather(gSampler, float4(0.1, 0.2, 0.3, 0.4));

    return 1.0;
}
