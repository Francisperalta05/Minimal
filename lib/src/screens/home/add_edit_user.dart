import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tots_test/src/extensions/empty_check.dart';
import 'package:tots_test/src/extensions/navigation.dart';
import 'package:tots_test/src/extensions/sizer.dart';
import 'package:tots_test/src/models/user_list.dart';
import 'package:tots_test/src/utils/images_path.dart';
import 'package:tots_test/src/extensions/validators.dart';

import '../../bloc/users_bloc/users_bloc.dart';
import '../../utils/colors.dart';
import '../widgets/painter.dart';

class AddEditUser extends StatefulWidget {
  final String title;
  final bool isEditting;
  final UserModel? user;

  const AddEditUser({
    super.key,
    required this.title,
    required this.isEditting,
    this.user,
  });
  @override
  _AddEditUser createState() => _AddEditUser();
}

class _AddEditUser extends State<AddEditUser> {
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _captionController;
  final _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user?.firstname ?? "");
    _lastNameController =
        TextEditingController(text: widget.user?.lastname ?? "");
    _emailController = TextEditingController(text: widget.user?.email ?? "");
    _addressController =
        TextEditingController(text: widget.user?.address ?? "");
    _captionController =
        TextEditingController(text: widget.user?.caption ?? "");

    context.read<UserBloc>().add(RemovePhoto());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _captionController.dispose();
  }

  Future<void> _save() async {
    try {
      final validate = _globalKey.currentState?.validate();
      if (validate == true) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog.adaptive(
                content: CircularProgressIndicator.adaptive()));
        if (widget.isEditting) {
          widget.user?.email = _emailController.text.trim();
          widget.user?.firstname = _nameController.text.trim();
          widget.user?.lastname = _lastNameController.text.trim();
          widget.user?.address = _addressController.text.trim();
          widget.user?.caption = _captionController.text.trim();

          await context.read<UserBloc>().updateUser(widget.user!);
        } else {
          await context.read<UserBloc>().createUser(UserModel(
                email: _emailController.text.trim(),
                firstname: _nameController.text.trim(),
                lastname: _lastNameController.text.trim(),
                address: _addressController.text.trim(),
                caption: _captionController.text.trim(),
              ));
        }
      }
      context.pop();
    } on Exception catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog.adaptive(
                content: Text(
                  e.toString(),
                  style: TextStyle(
                    fontSize: 20.w,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: context.pop,
                    child: const Text("Close"),
                  ),
                ],
              ));
    } finally {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0)
            .copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.w,
                        color: color222222),
                  ),
                ),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Tomar una foto'),
                                onTap: () {
                                  Navigator.of(context)
                                      .pop(); // Cierra el modal
                                  context
                                      .read<UserBloc>()
                                      .add(GetPhoto(ImageSource.camera));
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Seleccionar desde galería'),
                                onTap: () {
                                  Navigator.of(context)
                                      .pop(); // Cierra el modal
                                  context
                                      .read<UserBloc>()
                                      .add(GetPhoto(ImageSource.gallery));
                                },
                              ),
                              SizedBox(height: 50.h),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return CustomPaint(
                        painter: DashedCirclePainter(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: state.userPhoto.isNullOrEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            AppImages.imageSample),
                                        color: Colors.grey,
                                        width: 30.w,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        "Upload image",
                                        style: TextStyle(
                                          fontSize: 14.w,
                                          color: color080816.withOpacity(.38),
                                        ),
                                      ),
                                    ],
                                  )
                                : Image(
                                    image: MemoryImage(state.userPhoto!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'First name*'),
                  validator: (value) => value?.validateValue,
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last name*'),
                  validator: (value) => value?.validateValue,
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _emailController,
                  decoration:
                      const InputDecoration(labelText: 'Email address*'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value?.validateEmail,
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _captionController,
                  decoration: const InputDecoration(
                    labelText: 'Caption',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 50.h),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: context.pop,
                          child: Text(
                            'Cancel',
                            style:
                                TextStyle(color: color080816.withOpacity(.38)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.h),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _save,
                          child: const Text('SAVE'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
