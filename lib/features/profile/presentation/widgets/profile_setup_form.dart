import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/utils/validators.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:ridemates/features/profile/presentation/widgets/avatar_picker.dart';
import 'package:ridemates/features/profile/presentation/widgets/cycling_type_selector.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Profile setup form section: avatar, display name, riding type and bio.
/// The owning screen holds the [formKey] + controllers and the submit button.
class ProfileSetupForm extends StatelessWidget {
  const ProfileSetupForm({
    required this.formKey,
    required this.nameController,
    required this.bioController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = context.select<ProfileSetupBloc, CyclingType?>(
      (bloc) => bloc.state.cyclingType,
    );
    final avatarUrl = context.select<ProfileSetupBloc, String?>(
      (bloc) => bloc.state.avatarUrl,
    );
    final isUploadingAvatar = context.select<ProfileSetupBloc, bool>(
      (bloc) => bloc.state.isUploadingAvatar,
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AvatarPicker(
              semanticLabel: l10n.addPhotoLabel,
              imageUrl: avatarUrl,
              isLoading: isUploadingAvatar,
              onTap: () => context.read<ProfileSetupBloc>().add(
                const ProfileSetupAvatarPickRequested(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            label: l10n.displayNameLabel,
            hintText: l10n.displayNameHint,
            controller: nameController,
            textInputAction: TextInputAction.next,
            validator: (value) => Validators.required(
              value,
              requiredMessage: l10n.validationDisplayNameRequired,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.ridePreferenceQuestion,
            style: AppTypography.label.copyWith(letterSpacing: 0),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Required: cyclingType is what drives needsProfileSetup, so the
          // selector takes part in form validation.
          FormField<CyclingType>(
            initialValue: selected,
            validator: (value) =>
                value == null ? l10n.validationCyclingTypeRequired : null,
            builder: (field) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CyclingTypeSelector(
                  selected: selected,
                  onSelected: (type) {
                    context.read<ProfileSetupBloc>().add(
                      ProfileSetupCyclingTypeSelected(type),
                    );
                    field.didChange(type);
                  },
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      field.errorText!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: l10n.shortBioLabel,
            hintText: l10n.shortBioHint,
            controller: bioController,
            maxLines: 3,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
