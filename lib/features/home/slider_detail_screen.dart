import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';

import '../../config/constant.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/shared_widget/network_image_view.dart';
import 'cubit/detail_slider_cubit.dart';

// ignore: must_be_immutable
class SliderDetailScreen extends StatelessWidget {
  SliderDetailScreen({super.key, required this.slug});
  final String slug;

  late DetailSliderCubit _detailSliderCubit;

  @override
  Widget build(BuildContext context) {
    _detailSliderCubit = context.read();
    _detailSliderCubit.init();
    _detailSliderCubit.detailSlider(slug: slug);
    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Slider'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DetailSliderCubit, DetailSliderState>(
          builder: (context, state) {
            if (state is DetailSliderStateSuccess) {
              return Padding(
                padding: const EdgeInsets.all(space400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: NetworkImageView(
                        url: '${baseImage}/${state.data.thumbnail}',
                      ),
                    ),
                    SizedBox(height: space300),
                    Text(state.data.title ?? ""),
                    SizedBox(height: space400),
                    Text(state.data.description ?? ""),
                  ],
                ),
              );
            } else if (state is DetailSliderStateError) {
              return ErrorView(title: "Error", desc: state.message);
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ipsum duis minim aliquip amet nisi veniam quis enim occaecat veniam fugiat et duis. Cupidatat et eu consectetur veniam non. Reprehenderit mollit ex laborum reprehenderit cupidatat est sint occaecat nisi. Aute aliqua id adipisicing nisi. Adipisicing proident officia commodo dolore minim ullamco excepteur Lorem do. Excepteur incididunt qui pariatur commodo qui veniam fugiat id dolore non ex.',
                  ).addShimmer(block: true)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
