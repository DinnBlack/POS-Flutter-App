import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../../../core/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../../core/widgets/common_widgets/custom_text_field.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../core/utils/app_text_style.dart';

void showAddCategoryBottomSheet(BuildContext context) {
  final TextEditingController categoryController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(kBorderRadiusMd)),
          color: kColorWhite,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: kPaddingMd,
              right: kPaddingMd,
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
                    const SizedBox(height: kMarginMd),
                    Stack(
                      children: [
                        Center(
                          child: Text(
                            'Thêm Danh Mục',
                            style: AppTextStyle.semibold(
                                kTextSizeMd),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: kMarginMd,
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
                    const SizedBox(height: kMarginMd),
                    CustomTextField(
                      hintText: 'Nhập tên danh mục',
                      controller: categoryController,
                      autofocus: true,
                      isRequired: true,
                    ),
                    const SizedBox(height: kMarginMd),
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
                        padding: EdgeInsets.symmetric(vertical: kMarginMd),
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
