part of clean_nepali_calendar;

typedef Widget HeaderBuilder(
  BoxDecoration decoration,
  double height,
  Function nextMonthHandler,
  Function prevMonthHandler,
  NepaliDateTime nepaliDateTime,
);

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({
    Key key,
    @required Language language,
    @required Animation<double> chevronOpacityAnimation,
    @required bool isDisplayingFirstMonth,
    @required NepaliDateTime previousMonthDate,
    @required NepaliDateTime date,
    @required bool isDisplayingLastMonth,
    @required NepaliDateTime nextMonthDate,
    @required HeaderStyle headerStyle,
    @required Function() handleNextMonth,
    @required Function() handlePreviousMonth,
    @required this.onHeaderTapped,
    @required this.onHeaderLongPressed,
    @required changeToToday,
    HeaderBuilder headerBuilder,
  })  : _chevronOpacityAnimation = chevronOpacityAnimation,
        _isDisplayingFirstMonth = isDisplayingFirstMonth,
        _previousMonthDate = previousMonthDate,
        date = date,
        _isDisplayingLastMonth = isDisplayingLastMonth,
        _nextMonthDate = nextMonthDate,
        _headerStyle = headerStyle,
        _handleNextMonth = handleNextMonth,
        _handlePreviousMonth = handlePreviousMonth,
        _language = language,
        _changeToToday = changeToToday,
        _headerBuilder = headerBuilder,
        super(key: key);

  final Animation<double> _chevronOpacityAnimation;
  final bool _isDisplayingFirstMonth;
  final NepaliDateTime _previousMonthDate;
  final NepaliDateTime date;
  final bool _isDisplayingLastMonth;
  final NepaliDateTime _nextMonthDate;
  final HeaderStyle _headerStyle;
  final Function() _handleNextMonth;
  final Function() _handlePreviousMonth;
  final Function() _changeToToday;
  final Language _language;
  final HeaderGestureCallback onHeaderTapped;
  final HeaderGestureCallback onHeaderLongPressed;
  final HeaderBuilder _headerBuilder;

  _onHeaderTapped() {
    if (onHeaderTapped != null) {
      onHeaderTapped(date);
    }
  }

  _onHeaderLongPressed() {
    if (onHeaderLongPressed != null) {
      onHeaderLongPressed(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onHeaderTapped,
      onLongPress: _onHeaderLongPressed,
      child: (_headerBuilder != null)
          ? _headerBuilder(_headerStyle.decoration, _kDayPickerRowHeight,
              _handleNextMonth, _handlePreviousMonth, date)
          : Padding(
            padding: const EdgeInsets.only(left: 14,right: 14,top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF036C99),


                borderRadius: BorderRadius.circular(5),

              ),
                height: 35,

                //decoration: _headerStyle.decoration,

               // height: _kDayPickerRowHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Semantics(
                      sortKey: _MonthPickerSortKey.previousMonth,
                      child: FadeTransition(
                        opacity: _chevronOpacityAnimation,
                        child: IconButton(
                          color: Colors.white,

                          padding: _headerStyle.leftChevronPadding,
                          icon: Icon(Icons.arrow_back_ios,size: 15,),
                          tooltip: _isDisplayingFirstMonth
                              ? null
                              : 'Previous month ${formattedMonth(_previousMonthDate.month, Language.english)} ${_previousMonthDate.year}',
                          onPressed: _isDisplayingFirstMonth
                              ? null
                              : _handlePreviousMonth,
                        ),
                      ),
                    ),
                    // Text('555',style: TextStyle(fontSize: 18,color: Colors.white),),
                    // Text('77',style: TextStyle(fontSize: 18,color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(right: 100.0),
                        child: Text(
                          _headerStyle.titleTextBuilder != null
                              ? _headerStyle.titleTextBuilder(
                                  date,
                                  _language,
                                )
                              : '${formattedMonth(date.month, _language)} ${_language == Language.english ? date.year : NepaliUnicode.convert('${date.year}')}',
                         // style: _headerStyle.titleTextStyle,
                          style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 14),
                          textAlign: _headerStyle.centerHeaderTitle
                              ? TextAlign.center
                              : TextAlign.start,
                        ),
                      ),
                    //checking data text
                    //here finding date current date

                    // Text(
                    //   _headerStyle.titleTextBuilder != null
                    //       ? _headerStyle.titleTextBuilder(
                    //     date,
                    //     _language,
                    //   )
                    //       : '${formattedMonth(date.month, _language)}',
                    //   //here date
                    //    //
                    //   // style: _headerStyle.titleTextStyle,
                    //   style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 14),
                    //   textAlign: _headerStyle.centerHeaderTitle
                    //       ? TextAlign.center
                    //       : TextAlign.start,
                    // ),
                    // SizedBox(
                    //   width: 120,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(
                        //   height: 5,
                        // ),
                            Text(
                          //writing english date here
                          _headerStyle.titleTextBuilder != null
                              ? _headerStyle.titleTextBuilder(
                                  date,
                                  _language,
                                )
                          //jab/feb 2022
                              : "${getFormattedEnglishMonth(date.toDateTime().month)}/${getFormattedEnglishMonth(date.toDateTime().month + 1)} " ,style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),) ,
                        Text( " ${date.toDateTime().year}",
                       style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),)

                      ],
                    ),

                //i will get it right after
                //     Text(
                //   //writing english date here
                //   _headerStyle.titleTextBuilder != null
                //       ? _headerStyle.titleTextBuilder(
                //           date,
                //           _language,
                //         )
                //   //jab/feb 2022
                //       : "${getFormattedEnglishMonth(date.toDateTime().month)}/${getFormattedEnglishMonth(date.toDateTime().month + 1)} "
                //       "-"
                //       " ${date.toDateTime().year}",
                //   style: _headerStyle.titleTextStyle
                //       .copyWith(fontWeight: FontWeight.normal, fontSize: 14,color: Colors.white),
                //   textAlign: _headerStyle.centerHeaderTitle
                //       ? TextAlign.center
                //       : TextAlign.start,
                // ),



                    Semantics(
                      sortKey: _MonthPickerSortKey.nextMonth,
                      child: FadeTransition(
                        opacity: _chevronOpacityAnimation,
                        child: IconButton(
                          color: Colors.white,
                          padding: _headerStyle.rightChevronPadding,
                          icon: Icon(Icons.arrow_forward_ios,size: 15,),
                          tooltip: _isDisplayingLastMonth
                              ? null
                              : 'Next month ${formattedMonth(_nextMonthDate.month, Language.english)} ${_nextMonthDate.year}',
                          onPressed:
                              _isDisplayingLastMonth ? null : _handleNextMonth,
                        ),
                      ),
                    ),

                    // Icon(Icons.eighteen_mp,color: Colors.white,),
                    // Icon(Icons.eighteen_mp,color: Colors.white,),

                    //  Text('99999'),

                    //tala ko date and magh feb call method from here
                    // Expanded(
                    //   child: _headerStyle.centerHeaderTitle
                    //       ? Center(
                    //           child: _buildTitle(),
                    //         )
                    //       : _buildTitle(),
                    // ),



                    // InkWell(
                    //   onTap: _changeToToday,
                    //   child: Text(
                    //     _language == Language.english ? "Today" : 'Today',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // Semantics(
                    //   sortKey: _MonthPickerSortKey.previousMonth,
                    //   child: FadeTransition(
                    //     opacity: _chevronOpacityAnimation,
                    //     child: IconButton(
                    //       padding: _headerStyle.leftChevronPadding,
                    //       icon: _headerStyle.leftChevronIcon,
                    //       tooltip: _isDisplayingFirstMonth
                    //           ? null
                    //           : 'Previous month ${formattedMonth(_previousMonthDate.month, Language.english)} ${_previousMonthDate.year}',
                    //       onPressed: _isDisplayingFirstMonth
                    //           ? null
                    //           : _handlePreviousMonth,
                    //     ),
                    //   ),
                    // ),
                    // Semantics(
                    //   sortKey: _MonthPickerSortKey.nextMonth,
                    //   child: FadeTransition(
                    //     opacity: _chevronOpacityAnimation,
                    //     child: IconButton(
                    //       padding: _headerStyle.rightChevronPadding,
                    //       icon: _headerStyle.rightChevronIcon,
                    //       tooltip: _isDisplayingLastMonth
                    //           ? null
                    //           : 'Next month ${formattedMonth(_nextMonthDate.month, Language.english)} ${_nextMonthDate.year}',
                    //       onPressed:
                    //           _isDisplayingLastMonth ? null : _handleNextMonth,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
          ),
    );
  }

  Widget _buildTitle() {
    return FadeTransition(
      opacity: _chevronOpacityAnimation,
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          //MAGJ AND DATE START FROM HERE
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       children: [
          //       //writing magh date 2078 here
          //         Text(
          //           _headerStyle.titleTextBuilder != null
          //               ? _headerStyle.titleTextBuilder(
          //                   date,
          //                   _language,
          //                 )
          //               : '${formattedMonth(date.month, _language)} - ${_language == Language.english ? date.year : NepaliUnicode.convert('${date.year}')}',
          //           style: _headerStyle.titleTextStyle,
          //           textAlign: _headerStyle.centerHeaderTitle
          //               ? TextAlign.center
          //               : TextAlign.start,
          //         ),
          //        // Icon(Icons.arrow_drop_down)
          //       ],
          //     ),
          //     Text(
          //       //writing english date here
          //       _headerStyle.titleTextBuilder != null
          //           ? _headerStyle.titleTextBuilder(
          //               date,
          //               _language,
          //             )
          //       //jab/feb 2022
          //           : "${getFormattedEnglishMonth(date.toDateTime().month)}/${getFormattedEnglishMonth(date.toDateTime().month + 1)} -"
          //           " ${date.toDateTime().year}",
          //       style: _headerStyle.titleTextStyle
          //           .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
          //       textAlign: _headerStyle.centerHeaderTitle
          //           ? TextAlign.center
          //           : TextAlign.start,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

String getFormattedEnglishMonth(int mnth) {
  switch (mnth) {
    case DateTime.january:
      return "Jan";
    case DateTime.february:
      return "Feb";
    case DateTime.march:
      return "Mar";
    case DateTime.april:
      return "April";
    case DateTime.june:
      return "Jun";
    case DateTime.july:
      return "Jul";
    case DateTime.august:
      return "Aug";
    case DateTime.september:
      return "Sep";
    case DateTime.october:
      return "Oct";
    case DateTime.november:
      return "Nov";
    case DateTime.december:
      return "Dec";
    default:
      return "Jan";
  }
}
