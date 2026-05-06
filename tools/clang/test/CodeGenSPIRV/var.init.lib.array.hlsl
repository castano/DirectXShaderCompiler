// RUN: %dxc -T lib_6_3 -fspv-target-env=universal1.5 -fcgl %s -spirv | FileCheck %s

// In library mode there is no entry-function body to inject deferred
// OpStore initialization into. Verify that file-scope `static const`
// arrays get an OpConstantComposite Initializer on their OpVariable.

// CHECK-DAG: OpCapability Shader
// CHECK-DAG: OpCapability Linkage
// CHECK-DAG: OpDecorate %lookup LinkageAttributes "lookup" Export
// CHECK-DAG: [[init:%[_0-9A-Za-z]+]] = OpConstantComposite %_arr_uint_uint_4 %uint_10 %uint_20 %uint_30 %uint_40
// CHECK-DAG: %table = OpVariable %_ptr_Private__arr_uint_uint_4 Private [[init]]

static const uint table[4] = { 10u, 20u, 30u, 40u };

export uint lookup(uint i) {
    return table[i];
}
