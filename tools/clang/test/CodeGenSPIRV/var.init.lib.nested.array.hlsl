// RUN: %dxc -T lib_6_3 -fspv-target-env=universal1.5 -fcgl %s -spirv | FileCheck %s

// Verify that nested `static const` arrays in library mode also get an
// OpConstantComposite Initializer on their OpVariable, exercising the
// recursive fold path.

// CHECK-DAG: OpDecorate %lookup LinkageAttributes "lookup" Export
// CHECK-DAG: [[row0:%[_0-9A-Za-z]+]] = OpConstantComposite %_arr_uint_uint_2 %uint_1 %uint_2
// CHECK-DAG: [[row1:%[_0-9A-Za-z]+]] = OpConstantComposite %_arr_uint_uint_2 %uint_3 %uint_4
// CHECK-DAG: [[init:%[_0-9A-Za-z]+]] = OpConstantComposite %_arr__arr_uint_uint_2_uint_2 [[row0]] [[row1]]
// CHECK-DAG: %grid = OpVariable %_ptr_Private__arr__arr_uint_uint_2_uint_2 Private [[init]]

static const uint grid[2][2] = { { 1u, 2u }, { 3u, 4u } };

export uint lookup(uint y, uint x) {
    return grid[y][x];
}
