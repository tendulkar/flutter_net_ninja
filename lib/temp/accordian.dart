// import 'package:flutter/material.dart';
// import 'base_component.dart';
// import '../ui_spec.dart';

// /// Accordion item model
// class AccordionItem {
//   final String id;
//   final String title;
//   final String? subtitle;
//   final IconData? leadingIcon;
//   final bool isExpanded;
//   final bool isDisabled;
//   final Map<String, dynamic>? content;
//   final List<BaseComponent>? children;

//   const AccordionItem({
//     required this.id,
//     required this.title,
//     this.subtitle,
//     this.leadingIcon,
//     this.isExpanded = false,
//     this.isDisabled = false,
//     this.content,
//     this.children,
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'subtitle': subtitle,
//         'leadingIcon': leadingIcon?.codePoint,
//         'isExpanded': isExpanded,
//         'isDisabled': isDisabled,
//         'content': content,
//         'children': children?.map((child) => child.toJson()).toList(),
//       };

//   factory AccordionItem.fromJson(Map<String, dynamic> json) {
//     List<BaseComponent>? childComponents;

//     if (json['children'] != null) {
//       childComponents = [];
//       // Note: In a real implementation, you would use ComponentRegistry
//       // to create the appropriate component based on the type
//     }

//     return AccordionItem(
//       id: json['id'],
//       title: json['title'],
//       subtitle: json['subtitle'],
//       leadingIcon: json['leadingIcon'] != null
//           ? IconData(json['leadingIcon'], fontFamily: 'MaterialIcons')
//           : null,
//       isExpanded: json['isExpanded'] ?? false,
//       isDisabled: json['isDisabled'] ?? false,
//       content: json['content'],
//       children: childComponents,
//     );
//   }
// }

// /// Properties for Accordion component
// class AccordionProps extends BaseComponentProps {
//   final List<AccordionItem> items;
//   final bool allowMultiple;
//   final EdgeInsets? itemPadding;
//   final EdgeInsets? contentPadding;
//   final Function(String, bool)? onItemToggle;
//   final double? borderRadius;
//   final bool showDividers;
//   final bool animated;
//   final Duration animationDuration;
//   final BoxDecoration? itemDecoration;
//   final TextStyle? titleStyle;
//   final TextStyle? subtitleStyle;
//   final double spacing;

//   const AccordionProps({
//     super.style,
//     required this.items,
//     this.allowMultiple = false,
//     this.itemPadding,
//     this.contentPadding,
//     this.onItemToggle,
//     this.borderRadius,
//     this.showDividers = true,
//     this.animated = true,
//     this.animationDuration = const Duration(milliseconds: 300),
//     this.itemDecoration,
//     this.titleStyle,
//     this.subtitleStyle,
//     this.spacing = 4.0,
//   });

//   @override
//   Map<String, dynamic> toJson() => {
//         ...super.toJson(),
//         'items': items.map((item) => item.toJson()).toList(),
//         'allowMultiple': allowMultiple,
//         'itemPadding': itemPadding != null
//             ? {
//                 'left': itemPadding!.left,
//                 'top': itemPadding!.top,
//                 'right': itemPadding!.right,
//                 'bottom': itemPadding!.bottom,
//               }
//             : null,
//         'contentPadding': contentPadding != null
//             ? {
//                 'left': contentPadding!.left,
//                 'top': contentPadding!.top,
//                 'right': contentPadding!.right,
//                 'bottom': contentPadding!.bottom,
//               }
//             : null,
//         'borderRadius': borderRadius,
//         'showDividers': showDividers,
//         'animated': animated,
//         'animationDuration': animationDuration.inMilliseconds,
//         'itemDecoration': itemDecoration != null
//             ? {
//                 'color': itemDecoration!.color?.value,
//                 'borderRadius': itemDecoration!.borderRadius != null
//                     ? (itemDecoration!.borderRadius as BorderRadius).topLeft.x
//                     : null,
//               }
//             : null,
//         'titleStyle': {
//           'fontSize': titleStyle?.fontSize,
//           'fontWeight': titleStyle?.fontWeight?.index,
//           'color': titleStyle?.color?.value,
//         },
//         'subtitleStyle': {
//           'fontSize': subtitleStyle?.fontSize,
//           'fontWeight': subtitleStyle?.fontWeight?.index,
//           'color': subtitleStyle?.color?.value,
//         },
//         'spacing': spacing,
//       };

//   factory AccordionProps.fromJson(Map<String, dynamic> json) {
//     return AccordionProps(
//       style: json['style'] == null ? null : UIStyle.fromJson(json['style']),
//       items: (json['items'] as List?)
//               ?.map((item) => AccordionItem.fromJson(item))
//               .toList() ??
//           [],
//       allowMultiple: json['allowMultiple'] ?? false,
//       itemPadding: json['itemPadding'] != null
//           ? EdgeInsets.only(
//               left: json['itemPadding']['left'] ?? 0,
//               top: json['itemPadding']['top'] ?? 0,
//               right: json['itemPadding']['right'] ?? 0,
//               bottom: json['itemPadding']['bottom'] ?? 0,
//             )
//           : null,
//       contentPadding: json['contentPadding'] != null
//           ? EdgeInsets.only(
//               left: json['contentPadding']['left'] ?? 0,
//               top: json['contentPadding']['top'] ?? 0,
//               right: json['contentPadding']['right'] ?? 0,
//               bottom: json['contentPadding']['bottom'] ?? 0,
//             )
//           : null,
//       borderRadius: json['borderRadius'],
//       showDividers: json['showDividers'] ?? true,
//       animated: json['animated'] ?? true,
//       animationDuration: json['animationDuration'] != null
//           ? Duration(milliseconds: json['animationDuration'])
//           : const Duration(milliseconds: 300),
//       itemDecoration: json['itemDecoration'] != null
//           ? BoxDecoration(
//               color: json['itemDecoration']['color'] != null
//                   ? Color(json['itemDecoration']['color'])
//                   : null,
//               borderRadius: json['itemDecoration']['borderRadius'] != null
//                   ? BorderRadius.circular(
//                       json['itemDecoration']['borderRadius'])
//                   : null,
//             )
//           : null,
//       titleStyle: json['titleStyle'] != null
//           ? TextStyle(
//               fontSize: json['titleStyle']['fontSize'],
//               fontWeight: json['titleStyle']['fontWeight'] != null
//                   ? FontWeight.values[json['titleStyle']['fontWeight']]
//                   : null,
//               color: json['titleStyle']['color'] != null
//                   ? Color(json['titleStyle']['color'])
//                   : null,
//             )
//           : null,
//       subtitleStyle: json['subtitleStyle'] != null
//           ? TextStyle(
//               fontSize: json['subtitleStyle']['fontSize'],
//               fontWeight: json['subtitleStyle']['fontWeight'] != null
//                   ? FontWeight.values[json['subtitleStyle']['fontWeight']]
//                   : null,
//               color: json['subtitleStyle']['color'] != null
//                   ? Color(json['subtitleStyle']['color'])
//                   : null,
//             )
//           : null,
//       spacing: json['spacing'] ?? 4.0,
//     );
//   }
// }

// /// Accordion component implementation
// class AccordionComponent extends BaseComponent<AccordionProps> {
//   const AccordionComponent({
//     required super.props,
//   }) : super(type: 'accordion');

//   factory AccordionComponent.fromJson(Map<String, dynamic> json) {
//     return AccordionComponent(
//       props: AccordionProps.fromJson(json['props'] ?? {}),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return ExpansionPanelList(
//       expandedHeaderPadding: EdgeInsets.zero,
//       dividerColor: props.showDividers ? null : Colors.transparent,
//       elevation: 0,
//       expansionCallback: (index, isExpanded) {
//         if (props.onItemToggle != null) {
//           props.onItemToggle!(props.items[index].id, !isExpanded);
//         }
//       },
//       animationDuration:
//           props.animated ? props.animationDuration : Duration.zero,
//       children: props.items.map<ExpansionPanel>((item) {
//         return ExpansionPanel(
//           headerBuilder: (context, isExpanded) {
//             return Container(
//               padding: props.itemPadding ??
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               decoration: props.itemDecoration,
//               child: Row(
//                 children: [
//                   if (item.leadingIcon != null) ...[
//                     Icon(
//                       item.leadingIcon,
//                       color: item.isDisabled
//                           ? theme.disabledColor
//                           : theme.primaryColor,
//                       size: 24,
//                     ),
//                     SizedBox(width: 12),
//                   ],
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.title,
//                           style: props.titleStyle?.copyWith(
//                                 color: item.isDisabled
//                                     ? theme.disabledColor
//                                     : props.titleStyle?.color,
//                               ) ??
//                               theme.textTheme.titleMedium?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: item.isDisabled
//                                     ? theme.disabledColor
//                                     : null,
//                               ),
//                         ),
//                         if (item.subtitle != null) ...[
//                           SizedBox(height: props.spacing),
//                           Text(
//                             item.subtitle!,
//                             style: props.subtitleStyle?.copyWith(
//                                   color: item.isDisabled
//                                       ? theme.disabledColor.withOpacity(0.7)
//                                       : props.subtitleStyle?.color,
//                                 ) ??
//                                 theme.textTheme.bodySmall?.copyWith(
//                                   color: item.isDisabled
//                                       ? theme.disabledColor.withOpacity(0.7)
//                                       : theme.textTheme.bodySmall?.color,
//                                 ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           body: Container(
//             padding: props.contentPadding ?? const EdgeInsets.all(16.0),
//             width: double.infinity,
//             child: item.children != null && item.children!.isNotEmpty
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: item.children!.map((child) => child).toList(),
//                   )
//                 : item.content != null
//                     ? Text(item.content.toString())
//                     : const SizedBox.shrink(),
//           ),
//           isExpanded: item.isExpanded,
//           canTapOnHeader: !item.isDisabled,
//           backgroundColor:
//               item.isDisabled ? theme.disabledColor.withOpacity(0.05) : null,
//         );
//       }).toList(),
//     );
//   }
// }
