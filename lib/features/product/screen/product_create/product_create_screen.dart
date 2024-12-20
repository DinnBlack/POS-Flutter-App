import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/category/bloc/category_bloc.dart';
import '../../../../core/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../../core/widgets/common_widgets/custom_text_field.dart';
import '../../../../core/widgets/normal_widgets/custom_button_add_image.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../category/screen/categories_list/categories_list_add_product_screen.dart';
import '../../model/product_model.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/format_text.dart';
import 'package:image_picker/image_picker.dart';

class ProductCreateScreen extends StatefulWidget {
  static const route = 'ProductCreateScreen';

  final bool isEditing;
  final ProductModel? existingProduct;

  const ProductCreateScreen({
    super.key,
    this.isEditing = false,
    this.existingProduct,
  });

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _promotionPriceController =
      TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<XFile>? _selectedImages = [];

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.existingProduct != null) {
      _titleController.text = widget.existingProduct!.title;
      _sellingPriceController.text =
           FormatText.formatCurrency(widget.existingProduct!.price);
      _costPriceController.text =
          FormatText.formatCurrency(widget.existingProduct!.primeCost!);
      _promotionPriceController.text =
          FormatText.formatCurrency(widget.existingProduct!.promotionCost!);
      _unitController.text = widget.existingProduct!.unit ?? '';
      _descriptionController.text = widget.existingProduct!.description ?? '';
      _selectedImages = widget.existingProduct!.image
          ?.map((imagePath) => XFile(imagePath))
          .toList();
    }
  }

  void _validateAllFields() {
    bool hasError = false;

    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tên sản phẩm không được để trống'),
        ),
      );
      hasError = true;
    } else if (_sellingPriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giá bán không được để trống'),
        ),
      );
      hasError = true;
    }

    print(context.read<CategoryBloc>().selectedCategoriesTitle);

    if (!hasError) {
      final product = ProductModel(
        title: _titleController.text,
        price: FormatText.parseCurrency(_sellingPriceController.text),
        primeCost: FormatText.parseCurrency(_costPriceController.text),
        promotionCost: FormatText.parseCurrency(_promotionPriceController.text),
        unit: _unitController.text,
        description: _descriptionController.text,
        categories: context.read<CategoryBloc>().selectedCategoriesTitle,
        image: _selectedImages?.map((image) => image.path).toList() ?? [],
      );

      print(product);

      context.read<ProductBloc>().add(ProductCreateStarted(product: product));
    }
  }

  Future<void> _pickImages(bool isCamera) async {
    final ImagePicker _picker = ImagePicker();

    print(isCamera);

    if (isCamera) {
      var cameraStatus = await Permission.camera.request();

      if (cameraStatus.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cần cấp quyền để sử dụng camera và thư viện ảnh'),
          ),
        );
        return;
      }

      try {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            _selectedImages!.add(image);
          });
        } else {
          print('Không có hình ảnh nào được chụp.');
        }
      } catch (e) {
        print('Lỗi mở camera: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra khi mở camera.')),
        );
      }
    } else {
      // Check photo library permission
      var galleryStatus = await Permission.photos.request();

      // if (galleryStatus.isDenied) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Cần cấp quyền để sử dụng thư viện ảnh'),
      //     ),
      //   );
      //   return;
      // }

      // Proceed to pick images from the gallery
      try {
        final List<XFile>? images = await _picker.pickMultiImage();
        if (images != null && images.isNotEmpty) {
          setState(() {
            _selectedImages!.addAll(images);
          });
        }
      } catch (e) {
        print('Lỗi khi chọn ảnh từ thư viện: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra khi chọn ảnh.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductCreateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sản phẩm đã được thêm thành công!'),
              duration: Duration(seconds: 2),
            ),
          );

          _titleController.clear();
          _sellingPriceController.clear();
          _costPriceController.clear();
          _promotionPriceController.clear();
          _unitController.clear();
          _descriptionController.clear();
          setState(() {
            _selectedImages?.clear();
          });
        } else if (state is ProductCreateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Có lỗi xảy ra khi thêm sản phẩm!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kColorBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kColorPrimary,
          title: Text(
            'Add Product',
            style: AppTextStyle.medium(kTextSizeXxl, kColorWhite),
          ),
          leading: IconButton(
            icon: const Icon(
              Iconsax.arrow_square_left,
              color: kColorWhite,
            ),
            onPressed: () {
              context.read<CategoryBloc>().add(CategoryClearSelectionStated());
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductCreateInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: kMarginMd),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Ảnh sản phẩm',
                          style:
                              AppTextStyle.medium(kTextSizeMd, kColorGrey),
                        ),
                      ),
                      Row(
                        children: [
                          CustomButtonAddImage(
                            onTap: _pickImages,
                          ),
                          const SizedBox(width: kMarginMd),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _selectedImages?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPaddingSm),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusMd),
                                      child: Image.file(
                                        File(_selectedImages![index].path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kMarginMd),
                      CustomTextField(
                        hintText: 'Tên sản phẩm',
                        title: 'Tên sản phẩm',
                        isRequired: true,
                        controller: _titleController,
                      ),
                      const SizedBox(height: kMarginMd),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Giá bán',
                              isNumeric: true,
                              title: 'Giá bán',
                              isRequired: true,
                              controller: _sellingPriceController,
                            ),
                          ),
                          const SizedBox(width: kMarginMd),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Giá vốn',
                              isNumeric: true,
                              title: 'Giá vốn',
                              controller: _costPriceController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kMarginMd),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Giá khuyến mãi',
                              isNumeric: true,
                              title: 'Giá khuyến mãi',
                              controller: _promotionPriceController,
                            ),
                          ),
                          const SizedBox(width: kMarginMd),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Đơn vị',
                              title: 'Đơn vị',
                              controller: _unitController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kMarginMd),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Danh mục',
                          style:
                              AppTextStyle.medium(kTextSizeMd, kColorGrey),
                        ),
                      ),
                      const CategoriesListAddProductScreen(),
                      const SizedBox(height: kMarginMd),
                      CustomTextField(
                        hintText: 'Mô tả',
                        title: 'Mô tả',
                        controller: _descriptionController,
                      ),
                      const SizedBox(height: kMarginMd),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          leftButtonText: 'Tạo thêm',
          onLeftButtonPressed: () {
            context.read<CategoryBloc>().add(CategoryClearSelectionStated());
          },
          rightButtonText: 'Hoàn tất',
          onRightButtonPressed: () {
            _validateAllFields();
            context.read<CategoryBloc>().add(CategoryClearSelectionStated(isAddProductPage: true));
          },
        ),
      ),
    );
  }
}
