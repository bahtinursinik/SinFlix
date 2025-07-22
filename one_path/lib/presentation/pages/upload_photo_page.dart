import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/core/services/navigation_service.dart';
import 'package:one_path/core/services/token_service.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/upload-photo/upload_photo_bloc.dart';
import 'package:one_path/presentation/blocs/upload-photo/upload_photo_event.dart';
import 'package:one_path/presentation/blocs/upload-photo/upload_photo_state.dart';
import 'package:one_path/presentation/routes/app_routes.dart';
import 'package:one_path/presentation/widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';

class UploadPhotoPage extends StatefulWidget {
  final bool fromProfile;

  const UploadPhotoPage({super.key, this.fromProfile = false});

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File? selectedImage;
  @override
  void initState() {
    super.initState();

    context.read<UploadPhotoBloc>().add(UploadPhotoReset());
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      // Orijinal dosya
      File originalFile = File(picked.path);

      // Sıkıştırma işlemi
      final imageBytes = await originalFile.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);
      if (!context.mounted) return;
      if (decodedImage == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context).imageNotProcessed)));
        return;
      }
      final compressedImage = img.encodeJpg(
        decodedImage,
        quality: 70, // %70 kalite
      );

      // Cihazın geçici dizinine kaydetme işlemi
      final tempDir = await getTemporaryDirectory();
      final compressedFile = File('${tempDir.path}/compressed_image.jpg');
      await compressedFile.writeAsBytes(compressedImage);

      setState(() {
        selectedImage = compressedFile;
      });

      final token = await TokenStorage.getToken();
      if (!context.mounted) return;
      if (token != null) {
        context.read<UploadPhotoBloc>().add(
              UploadPhotoRequested(token: token, filePath: compressedFile.path),
            );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context).tokenNotFound)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.white10,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: AppColors.white),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            const Spacer(flex: 1),
                            SizedBox(width: 20),
                            Text(
                              AppLocalizations.of(context).profileDetail,
                              style: AppTextStyles.medium18White,
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.06),
                        Text(
                          AppLocalizations.of(context).uploadPhotos,
                          style: AppTextStyles.semiBold18WhiteCentered,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          AppLocalizations.of(context).uploadPhotoInstruction,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regular13WhiteCentered,
                        ),
                        SizedBox(height: screenHeight * 0.06),
                        Center(
                          child: GestureDetector(
                            onTap: () => _pickImage(context),
                            child: Container(
                              width: screenWidth * 0.4,
                              height: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                color: AppColors.white10,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: AppColors.white10),
                              ),
                              child: selectedImage == null
                                  ? Center(
                                      child: Image.asset(
                                        ImagePaths.plus,
                                        width: screenWidth * 0.2,
                                        height: screenWidth * 0.2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
                          builder: (context, state) {
                            if (state is UploadPhotoLoading) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.red));
                            } else if (state is UploadPhotoSuccess) {
                              return Center(
                                child: Text(
                                  AppLocalizations.of(context).photoUploaded,
                                  style: const TextStyle(color: Colors.green),
                                ),
                              );
                            } else if (state is UploadPhotoFailure) {
                              return Center(
                                child: Text(
                                  "${AppLocalizations.of(context).error}: ${state.error}",
                                  style: const TextStyle(color: AppColors.red),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        CustomButton(
                          onTap: () {
                            final state = context.read<UploadPhotoBloc>().state;
                            if (widget.fromProfile) {
                              if (state is UploadPhotoSuccess) {
                                Navigator.of(context).pop(true);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)
                                          .pleaseUploadPhotoFirst,
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            } else {
                              NavigationService.navigateTo(AppRoutes.main);
                            }
                          },
                          text: widget.fromProfile
                              ? AppLocalizations.of(context).uploadPhoto
                              : AppLocalizations.of(context).continueText,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
