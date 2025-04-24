import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/traits_model.dart';
import 'package:trait_lens_admin/features/tabs/users/data/repositories/users_repository.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/user_details_view_model/user_details_screen_states.dart';

@injectable
class UserDetailsViewModel extends Cubit<UserDetailsScreenStates> {
  final UsersRepository _repository;

  UserDetailsViewModel(this._repository)
    : super(UserDetailsScreenInitialState());

  double parsePercentage(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value.replaceAll('%', '').trim()) ?? 0.0;
  }

  Traits calculateAverageTraits(List<Traits?> traitsList) {
    double avg(double Function(Traits t) extractor) {
      final valid = traitsList.whereType<Traits>().toList();
      if (valid.isEmpty) return 0.0;
      return valid.map(extractor).reduce((a, b) => a + b) / valid.length;
    }

    return Traits(
      opennessO:
          '${avg((t) => double.parse(t.opennessO?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      conscientiousnessC:
          '${avg((t) => double.parse(t.conscientiousnessC?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      extraversionE:
          '${avg((t) => double.parse(t.extraversionE?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      agreeablenessA:
          '${avg((t) => double.parse(t.agreeablenessA?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
      neuroticismN:
          '${avg((t) => double.parse(t.neuroticismN?.replaceAll('%', '') ?? '0')).toStringAsFixed(2)}%',
    );
  }

  DetectionResultModel createResultModel(Traits traits) {
    final List<MapEntry<String, double>> traitValues = [
      MapEntry('Openness(O)', parsePercentage(traits.opennessO)),
      MapEntry(
        'Conscientiousness(C)',
        parsePercentage(traits.conscientiousnessC),
      ),
      MapEntry('Extraversion(E)', parsePercentage(traits.extraversionE)),
      MapEntry('Agreeableness(A)', parsePercentage(traits.agreeablenessA)),
      MapEntry('Neuroticism(N)', parsePercentage(traits.neuroticismN)),
    ];

    final dominant = traitValues.reduce((a, b) => a.value > b.value ? a : b);

    return DetectionResultModel(dominantTrait: dominant.key, traits: traits);
  }

  List<PieChartSectionData> getPieChartSections(
    Traits traits, {
    double radius = 25,
    Color titleColor = Colors.transparent,
  }) {
    return [
      PieChartSectionData(
        color: AppTheme.openness,
        value: parsePercentage(traits.opennessO),
        title: '${parsePercentage(traits.opennessO).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(color: titleColor),
      ),
      PieChartSectionData(
        color: AppTheme.conscientiousness,
        value: parsePercentage(traits.conscientiousnessC),
        title:
            '${parsePercentage(traits.conscientiousnessC).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(color: titleColor),
      ),
      PieChartSectionData(
        color: AppTheme.extraversion,
        value: parsePercentage(traits.extraversionE),
        title: '${parsePercentage(traits.extraversionE).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(color: titleColor),
      ),
      PieChartSectionData(
        color: AppTheme.agreeableness,
        value: parsePercentage(traits.agreeablenessA),
        title: '${parsePercentage(traits.agreeablenessA).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(color: titleColor),
      ),
      PieChartSectionData(
        color: AppTheme.neuroticism,
        value: parsePercentage(traits.neuroticismN),
        title: '${parsePercentage(traits.neuroticismN).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(color: titleColor),
      ),
    ];
  }

  Future<void> getUserDetectionResults() async {
    emit(UserDetailsScreenLoadingState());

    final result = await _repository.getUserResults();

    result.fold(
      (error) {
        emit(
          UserDetailsScreenErrorState(error.message ?? 'Something went wrong'),
        );
      },
      (results) {
        if (results.isEmpty) {
          emit(UserDetailsScreenEmptyState());
        } else {
          emit(UserDetailsScreenLoadedState(results));
        }
      },
    );
  }
}
