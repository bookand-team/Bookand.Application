import 'package:bookand/app/page/terms_page.dart';
import 'package:bookand/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widget/check_button.dart';
import '../../widget/circle_check_button.dart';
import '../../widget/round_rect_button.dart';
import '../provider/terms_provider.dart';

const String content = """
# 샘플 한글입숨

때에, 생명을 노년에게서 만물은 갑 귀는 이상을 찾아 영원히 있으랴? 동력은 든 사는가 일월과 찬미를 칼이다. 할지라도 이것을 이상은 들어 칼이다. 과실이 위하여 충분히 사는가 칼이다. 청춘의 노년에게서 같으며, 힘차게 인류의 피어나는 내려온 무엇을 모래뿐일 아름다우냐? 튼튼하며, 보이는 장식하는 끝에 커다란 피다. 보이는 군영과 끓는 피어나는 만천하의 열락의 기쁘며, 무엇을 것이다. 이상의 풍부하게 있는 대중을 가치를 보는 이것이다. 수 이상의 같이, 가슴이 부패를 그들은 내려온 하여도 너의 이것이다. 피가 인생을 무한한 보는 꽃 그림자는 원질이 맺어, 현저하게 이것이다.

봄바람을 뛰노는 곳으로 심장은 길지 피가 것이다. 이 청춘의 온갖 소담스러운 쓸쓸한 것이다. 피어나기 못할 얼마나 있는 풍부하게 앞이 그러므로 것이다. 이상의 것은 사는가 못할 사막이다. 같은 인간이 광야에서 있는 열락의 따뜻한 우리 이것이야말로 밥을 것이다. 우리 낙원을 현저하게 때문이다. 영원히 미묘한 창공에 청춘 봄바람을 굳세게 행복스럽고 있다. 구하기 따뜻한 만물은 그들의 있는 봄날의 사랑의 부패뿐이다. 것은 만천하의 심장은 끓는다. 어디 끓는 천하를 곳이 황금시대의 위하여 없으면, 미인을 사막이다.

얼음과 그들의 뼈 풍부하게 넣는 우리 희망의 인류의 우리의 부패뿐이다. 광야에서 것은 간에 소담스러운 있는가? 얼마나 인간의 인생의 뿐이다. 우리의 같이, 황금시대의 위하여, 피어나기 있음으로써 불어 들어 넣는 교향악이다. 끓는 같은 아니한 속에 너의 거친 사람은 약동하다. 두손을 그들의 황금시대를 천고에 가장 과실이 철환하였는가? 고행을 그들의 많이 것이다. 이상의 그들을 이것은 심장의 바로 구하지 쓸쓸하랴? 고동을 같이, 노년에게서 무엇을 청춘의 어디 쓸쓸하랴? 동산에는 과실이 우는 튼튼하며, 되는 사막이다. 싶이 청춘의 만천하의 뜨고, 교향악이다.
""";

class TermsAgreePage extends HookConsumerWidget {
  const TermsAgreePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAgreeState = ref.watch(allAgreeProvider.notifier);
    final agree14YearsOfAgeOrOlderState = ref.watch(agree14YearsOfAgeOrOlderProvider.notifier);
    final agreeTermsOfServiceState = ref.watch(agreeTermsOfServiceProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          radius: 20,
          highlightColor: Colors.transparent,
          child: SvgPicture.asset(
            'assets/images/ic_arrow_back.svg',
            fit: BoxFit.none,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.termsOfServiceAgree,
                style: const TextStyle().termsOfServicePageTitle(),
              ),
              const SizedBox(height: 70),
              Row(
                children: [
                  CircleCheckButton(
                    value: ref.watch(allAgreeProvider),
                    onTap: () {
                      allAgreeState.changeAgree();
                    },
                  ),
                  const SizedBox(width: 19),
                  Text(
                    AppLocalizations.of(context)!.allAgree,
                    style: const TextStyle().termsOfServiceAllAgreeText(),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  CheckButton(
                      value: ref.watch(agree14YearsOfAgeOrOlderProvider),
                      onTap: () {
                        agree14YearsOfAgeOrOlderState.state = !agree14YearsOfAgeOrOlderState.state;
                        allAgreeState.checkAgreeList();
                      }),
                  const SizedBox(width: 20),
                  Text(AppLocalizations.of(context)!.termsOfServiceItem1,
                      style: const TextStyle().termsOfServiceItemText())
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CheckButton(
                          value: ref.watch(agreeTermsOfServiceProvider),
                          onTap: () {
                            agreeTermsOfServiceState.state = !agreeTermsOfServiceState.state;
                            allAgreeState.checkAgreeList();
                          }),
                      const SizedBox(width: 20),
                      Text(AppLocalizations.of(context)!.termsOfServiceItem2,
                          style: const TextStyle().termsOfServiceItemText())
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TermsPage(
                                  title: AppLocalizations.of(context)!
                                      .termsOfService,
                                  content: content))).then((value) {
                        if (value ?? false) {
                          ref
                              .watch(agreeTermsOfServiceProvider.notifier)
                              .state = value;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                        'assets/images/ic_arrow_forward.svg',
                        width: 20,
                        height: 20),
                  )
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CheckButton(
                          value: ref.watch(agreeCollectAndUsePrivacyProvider),
                          onTap: () {
                            var agree = ref.watch(
                                agreeCollectAndUsePrivacyProvider.notifier);
                            agree.state = !agree.state;
                            allAgreeState.checkAgreeList();
                          }),
                      const SizedBox(width: 20),
                      Text(AppLocalizations.of(context)!.termsOfServiceItem3,
                          style: const TextStyle().termsOfServiceItemText())
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TermsPage(
                                  title: AppLocalizations.of(context)!
                                      .collectAndUsePrivacy,
                                  content: content))).then((value) {
                        if (value ?? false) {
                          ref
                              .watch(agreeCollectAndUsePrivacyProvider.notifier)
                              .state = value;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                        'assets/images/ic_arrow_forward.svg',
                        width: 20,
                        height: 20),
                  )
                ],
              ),
              const Spacer(),
              RoundRectButton(
                  text: AppLocalizations.of(context)!.start,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {},
                  enabled: ref.watch(allAgreeProvider))
            ],
          ),
        ),
      ),
    );
  }
}
