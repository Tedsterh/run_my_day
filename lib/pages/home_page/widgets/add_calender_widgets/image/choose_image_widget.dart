import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity/icon/bloc/icon_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/image/image_picker.dart';

class ChooseIconWidget extends StatelessWidget {
  const ChooseIconWidget({
    Key key,
    @required this.icon 
  }) : super(key: key);
  final ValueNotifier<String> icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -30
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            BlocProvider.of<IconBloc>(context).add(PickIcon(context));
          },
          child: BlocConsumer<IconBloc, IconState>(
            listener: (listenerContext, state) {
              if (state is ShowIconPicker) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ImagePicker(
                      images: state.icons,
                      selected: (value) {
                        BlocProvider.of<IconBloc>(listenerContext).add(IconSelected(icon: value));
                        icon.value = value;
                      },
                      reset: () {
                        BlocProvider.of<IconBloc>(listenerContext).add(SetInitial());
                      },
                    );
                  }
                );
              }
            },
            builder: (context, state) {
              return Container(
                height: 75,
                width: 75,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: state is ChosenIcon ? 
                  SvgPicture.asset(
                    state.icon
                  ) : Container(
                    child: Center(
                      child: Text(
                        'Tap to choose icon',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}