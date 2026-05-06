import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/generated/l10n.dart';

class _PointsState {
  final int points;
  final int increasedPoints;
  final bool showFloating;

  _PointsState({
    required this.points,
    this.increasedPoints = 0,
    this.showFloating = false,
  });

  _PointsState copyWith({
    int? points,
    int? increasedPoints,
    bool? showFloating,
  }) {
    return _PointsState(
      points: points ?? this.points,
      increasedPoints: increasedPoints ?? this.increasedPoints,
      showFloating: showFloating ?? this.showFloating,
    );
  }
}

class CustomappBarPoints extends StatefulWidget {
  const CustomappBarPoints({super.key});

  @override
  State<CustomappBarPoints> createState() => _CustomappBarPointsState();
}

class _CustomappBarPointsState extends State<CustomappBarPoints>
    with TickerProviderStateMixin {
  late final ValueNotifier<_PointsState> _stateNotifier;
  late AnimationController _scaleController;
  late AnimationController _floatController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _floatAnimation;
  late StreamSubscription<int> _pointsSubscription;

  @override
  void initState() {
    super.initState();

    _stateNotifier = ValueNotifier<_PointsState>(
      _PointsState(points: Prefs.getInt(Kpoints)),
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _floatAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -80),
    ).animate(CurvedAnimation(parent: _floatController, curve: Curves.easeOut));

    // Store the subscription so it doesn't get garbage collected
    _pointsSubscription =
        Stream.periodic(
          const Duration(milliseconds: 100),
          (_) => Prefs.getInt(Kpoints),
        ).distinct().listen((currentPoints) {
          _checkAndUpdatePoints(currentPoints);
        });
  }

  void _checkAndUpdatePoints(int currentPoints) {
    int previousPoints = _stateNotifier.value.points;

    if (currentPoints > previousPoints) {
      final increase = currentPoints - previousPoints;
      _stateNotifier.value = _PointsState(
        points: currentPoints,
        increasedPoints: increase,
        showFloating: true,
      );

      _scaleController.forward().then((_) => _scaleController.reverse());
      _floatController.forward().then((_) {
        if (mounted) {
          _stateNotifier.value = _stateNotifier.value.copyWith(
            showFloating: false,
          );
        }
        _floatController.reset();
      });
    } else if (currentPoints != previousPoints) {
      _stateNotifier.value = _stateNotifier.value.copyWith(
        points: currentPoints,
      );
    }
  }

  @override
  void dispose() {
    _pointsSubscription.cancel();
    _stateNotifier.dispose();
    _scaleController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<_PointsState>(
      valueListenable: _stateNotifier,
      builder: (context, state, _) {
        return IntrinsicHeight(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDark ? KaccentColor : KprimaryColor,
                  borderRadius: BorderRadius.circular(7),
                  border: isDark
                      ? Border.all(
                          color: KprimaryColorLight.withOpacity(0.5),
                          width: 1,
                        )
                      : null,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Text(
                      '${state.points} ${S.of(context)!.profileViewPoints}',
                      style: AppTextStyles.cairoRegular.copyWith(
                        color: isDark ? KprimaryColorDark : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              if (state.showFloating)
                Positioned(
                  right: 0,
                  top: 0,
                  child: SlideTransition(
                    position: _floatAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff4CAF50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+${state.increasedPoints}',
                        style: AppTextStyles.cairoRegular.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
