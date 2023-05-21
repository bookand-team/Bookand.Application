import 'package:bookand/core/theme/color_table.dart';
import 'package:bookand/presentation/provider/error_report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';
import '../../../component/custom_switch.dart';
import '../../../component/round_rect_button.dart';

class ErrorReportScreen extends ConsumerWidget {
  static String get routeName => 'ErrorReportScreen';

  const ErrorReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorReportState = ref.watch(errorReportNotifierProvider);
    final errorReportProvider = ref.watch(errorReportNotifierProvider.notifier);

    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.errorReport),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              TextField(
                decoration: const InputDecoration(
                  hintText: '[필수] 예) 2023/08/23 13:15',
                  isDense: true,
                ),
                onChanged: errorReportProvider.onChangedErrorDateText,
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
                  onChanged: errorReportProvider.onChangedErrorContentText,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  hintText: '[필수] 답변 받을 이메일 주소',
                  isDense: true,
                ),
                onChanged: errorReportProvider.onChangedEmailText,
              ),
              const SizedBox(height: 12),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  final imagePicker = ImagePicker();
                  final images = await imagePicker.pickMultiImage();
                  if (images.isNotEmpty) {
                    errorReportProvider.addImage(images);
                  }
                },
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
                        text: '${errorReportState.imageSize}MB',
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
                visible: errorReportState.images.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    height: 72,
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Stack(
                          children: [
                            Image.memory(
                              errorReportState.images[index].readAsBytesSync(),
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  errorReportProvider.deleteImage(index);
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: SvgPicture.asset(
                                      'assets/images/my/ic_delete_image.svg',
                                      width: 10,
                                      height: 10,
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 6),
                      itemCount: errorReportState.images.length,
                      cacheExtent: 100,
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
                  value: errorReportState.sendLog,
                  onChanged: errorReportProvider.onChangedSendLog,
                ),
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
              ),
              InkWell(
                onTap: errorReportProvider.toggleTermsAgree,
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
                  trailing: SvgPicture.asset(
                    errorReportState.termsAgree
                        ? 'assets/images/ic_all_check_active.svg'
                        : 'assets/images/ic_all_check_inactive.svg',
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
              Visibility(
                visible: errorReportState.termsAgree,
                child: termsContent(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: errorReportState.termsAgree ? 20 : 56,
                  bottom: 22,
                ),
                child: RoundRectButton(
                    text: '접수하기',
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget termsContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '개인정보 수집 및 이용동의 안내',
            style: TextStyle(
              color: lightColorFF565656,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: -0.02,
            ),
          ),
          const Text(
            '북앤드는 이용자 문의를 처리하기 위해 다음과 같이 개인정보를 수집 및 이용하며, 이용자의 개인정보를 안전하게 취급하는데 최선을 다하고 있습니다.',
            style: TextStyle(
              color: lightColorFF565656,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: -0.02,
            ),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: lightColorFFACACAC),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },
            children: [
              TableRow(decoration: const BoxDecoration(color: lightColorFFF5F5F7), children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 34),
                    alignment: Alignment.center,
                    child: const Text(
                      '수집항목',
                      style: TextStyle(
                        color: lightColorFF565656,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 34),
                    alignment: Alignment.center,
                    child: const Text(
                      '수집목적',
                      style: TextStyle(
                        color: lightColorFF565656,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 34),
                    alignment: Alignment.center,
                    child: const Text(
                      '보유기간',
                      style: TextStyle(
                        color: lightColorFF565656,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                      ),
                    )),
              ]),
              TableRow(children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text(
                      '답변 받을 이메일 주소',
                      style: TextStyle(
                        color: lightColorFF565656,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text(
                      '필요한 경우, 오류 내용에 대한 상세확인을 위한 회신',
                      style: TextStyle(
                        color: lightColorFF565656,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text(
                      '6개월간 보관 후 지체없이 파기',
                      style: TextStyle(
                        color: lightColorFF565656,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: -0.02,
                      ),
                    )),
              ]),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '위 동의를 거부할 권리가 있으며, 동의를 거부하실 경우 문의 처리가 제한됩니다.',
            style: TextStyle(
              color: lightColorFF565656,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: -0.02,
            ),
          ),
        ],
      );
}
