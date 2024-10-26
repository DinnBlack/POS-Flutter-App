import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';

import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../widgets/common_widgets/custom_text_field.dart';

void showAddCategoryBottomSheet(BuildContext context) {
  final TextEditingController categoryController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(DEFAULT_BORDER_RADIUS)),
          color: WHITE_COLOR,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: DEFAULT_PADDING,
              right: DEFAULT_PADDING,
            ),
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryCreateSuccess) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Danh mục đã được tạo thành công!')),
                  );
                } else if (state is CategoryCreateFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Tạo danh mục thất bại: ${state.error}')),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: MEDIUM_MARGIN),
                    Stack(
                      children: [
                        Center(
                          child: Text(
                            'Thêm Danh Mục',
                            style: AppTextStyle.semibold(
                                MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: DEFAULT_MARGIN,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MEDIUM_MARGIN),
                    CustomTextField(
                      hintText: 'Nhập tên danh mục',
                      controller: categoryController,
                      autofocus: true,
                      isRequired: true,
                    ),
                    const SizedBox(height: MEDIUM_MARGIN),
                    CustomBottomBar(
                      leftButtonText: 'Huỷ',
                      rightButtonText: 'Tạo',
                      onLeftButtonPressed: () {
                        Navigator.of(context).pop();
                      },
                      onRightButtonPressed: () {
                        if (categoryController.text.isNotEmpty) {
                          context.read<CategoryBloc>().add(
                                CategoryCreateStated(categoryController.text),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Vui lòng nhập tên danh mục')),
                          );
                        }
                      },
                    ),
                    if (state is CategoryCreateInProgress)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: MEDIUM_MARGIN),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
