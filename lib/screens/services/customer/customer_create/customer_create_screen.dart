import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_text_field.dart';
import 'package:toastification/toastification.dart';

import '../../../../features/customer/bloc/customer_bloc.dart';
import '../../../../models/customer_model.dart';
import '../../../../widgets/common_widgets/toast_helper.dart';

class CustomerCreateScreen extends StatefulWidget {
  static const route = 'CustomerCreateScreen';

  const CustomerCreateScreen({super.key});

  @override
  State<CustomerCreateScreen> createState() => _CustomerCreateScreenState();
}

class _CustomerCreateScreenState extends State<CustomerCreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      resizeToAvoidBottomInset: false,
      body: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerCreateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Customer created successfully!')),
            );
            Navigator.pop(context);
          } else if (state is CustomerCreateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: MEDIUM_MARGIN,
              ),
              Stack(
                children: [
                  Center(
                    child: Text(
                      'Tạo khách hàng mới',
                      style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Icon(
                        Icons.close_rounded,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: SUPER_LARGE_MARGIN,
              ),
              _UserAvatarWithCameraIcon(
                onTap: () {},
              ),
              const SizedBox(
                height: MEDIUM_MARGIN,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Ví dụ: Nguyễn Văn A',
                title: 'Tên Khách hàng',
                isRequired: true,
                autofocus: true,
              ),
              const SizedBox(
                height: MEDIUM_MARGIN,
              ),
              CustomTextField(
                controller: _phoneController,
                hintText: 'Ví dụ: 0123456789',
                title: 'Số điện thoại',
                isRequired: true,
                isNumeric: true,
                isPhoneNumber: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        leftButtonText: 'Quay lại',
        rightButtonText: 'Tạo',
        onRightButtonPressed: () {
          final name = _nameController.text.trim();
          final phone = _phoneController.text.trim();
          if (name.isNotEmpty && phone.isNotEmpty) {
            final customer = CustomerModel(
              name: name,
              phoneNumber: phone,
              createdAt: DateTime.now(),
            );
            context.read<CustomerBloc>().add(CustomerCreateStated(customer));
            ToastHelper.showToast(
              context,
              'Thêm khách hàng thành công!',
              'Thông tin khách hàng đã được lưu.',
              ToastificationType.success,
            );
          } else {
            ToastHelper.showToast(
              context,
              'Nhập đầy đủ thông tin!',
              'Điền các thông tin tên và số điện thoại',
              ToastificationType.error,
            );
          }
        },
        onLeftButtonPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _UserAvatarWithCameraIcon extends StatelessWidget {
  final VoidCallback onTap;

  const _UserAvatarWithCameraIcon({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.grey[700],
            ),
          ),
          // Camera Icon Overlay
          Positioned(
            right: 4,
            bottom: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              padding: const EdgeInsets.all(SMALL_PADDING),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
