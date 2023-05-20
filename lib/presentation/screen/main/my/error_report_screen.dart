import 'package:bookand/core/theme/color_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';
import '../../../component/custom_switch.dart';
import '../../../component/round_rect_button.dart';

class ErrorReportScreen extends ConsumerStatefulWidget {
  static String get routeName => 'ErrorReportScreen';

  const ErrorReportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ErrorReportScreen> createState() => _ErrorReportScreenState();
}

class _ErrorReportScreenState extends ConsumerState<ErrorReportScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottomInset: false,
      appBar: const BaseAppBar(title: AppStrings.errorReport),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '오류 발생일시',
                  style: TextStyle(
                      color: lightColorFF222222,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.02),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '[필수] 예) 2023/08/23 13:15',
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '오류 발생일시를 입력해주세요';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                const Text(
                  '오류 내용',
                  style: TextStyle(
                      color: lightColorFF222222,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.02),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 232,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText:
                          '[필수] 아래 내용을 입력해주시면 오류 확인에 도움이 됩니다.\n - 문제 발생화면 : 예) 맵 > OO 서점 상세 화면\n - 문제 내용 : 예) 서점 이미지가 까맣게 보여요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '오류 내용을 입력해주세요';
                      }

                      return null;
                    },
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '[필수] 답변 받을 이메일 주소',
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일 주소를 입력해주세요';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                ),
                const SizedBox(height: 12),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '+ 이미지 첨부',
                      isDense: true,
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 22,
                        minHeight: 22,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset('assets/images/my/ic_clip.svg'),
                      ),
                    ),
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '첨부파일은 최대 5개, 30MB까지 등록 가능합니다.',
                      style: TextStyle(
                          color: lightColorFF565656,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.02),
                    ),
                    RichText(
                      text: TextSpan(
                          text: '0MB',
                          style: const TextStyle(
                              color: lightMainColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.02),
                          children: const [
                            TextSpan(
                              text: '/30MB',
                              style: TextStyle(
                                  color: lightColorFF565656,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.02),
                            ),
                          ]),
                    ),
                  ],
                ),
                Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      height: 72,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 72,
                            height: 72,
                            color: Colors.amber,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemCount: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  dense: true,
                  title: const Text(
                    '로그 전송',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: -0.02,
                    ),
                  ),
                  trailing: CustomSwitch(
                    value: true,
                    onChanged: (value) {},
                  ),
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                ),
                InkWell(
                  onTap: () {

                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: ListTile(
                    dense: true,
                    title: const Text(
                      '[필수] 개인 정보 수집, 이용 동의',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.02,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    trailing: InkWell(
                      onTap: () {

                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: CircleAvatar(radius: 9, backgroundColor: lightMainColor,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 56.0, bottom: 22),
                  child: RoundRectButton(
                    text: '접수하기',
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    onPressed: () {

                    },
                    enabled: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
