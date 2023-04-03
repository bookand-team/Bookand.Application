import 'package:bookand/presentation/provider/map/map_panel_visible_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_panel_content_type_provider.g.dart';

enum ContentType { list, showHide }

@Riverpod()
class MapPanelContentTypeNotifier extends _$MapPanelContentTypeNotifier {
  late MapPanelVisibleNotifier showPanelCon;
  @override
  ContentType build() {
    showPanelCon = ref.read(mapPanelVisibleNotifierProvider.notifier);
    return ContentType.list;
  }

  void toggle(ContentType type) {
    state = (state == type) ? ContentType.list : type;
  }

  toggleShowHide() {
    toggle(ContentType.showHide);
    showPanelCon.toggle();
  }

  toggleList() {
    toggle(ContentType.list);
    showPanelCon.toggle();
  }
}
