enum GameTypes {
  dragOut,
  clickPicture,
  clickTheSound,
  bingo,
  sortingCups,
  sortingPictures,
  dice,
  xOut,
  spelling,
  tracing,
  tracingArabic,
  clickPictureArabic,
  clickTheSoundArabic,
  dragOutArabic,
  repeatCharArabic,
  chooseCorrectWordArabic,
  chooseFormationArabic,
  matchingArabic,
  sortingCupsArabic,
  chooseTheCorrectCharArabic,
  createWordArabic,
  video,
  dragPicToWord,
  dragWordToPic,
  spellingWord,
  wordFamily,
  listenAndChoose,
  match,
  rearrange,
  clickTheWord,
  chooseTheSentence,
  chooseTheCorrect,
  sortingCupsUP,
  ninePicCards,
  mathChooseSticks,
  mathChooseBeads,
  mathChooseBlocks,
  mathChooseBeadsNumber,
  mathChooseBlocksNumber,
  mathChooseDominoNumber,
  mathSortingBlocks,
  mathChooseDomino,
  mathChooseDominoOE,
  mathDragDominoOE,
  mathDragBlocksOE,
  mathChooseBeadsOE,
  mathDragSticks,
  mathChooseBlocksAdd,
  mathChooseBeadsAdd,
  mathChooseBlocksAddLine,
  mathChooseBeadsAddLine,
  mathDragBlocksAdd,
  mathDragBeadsAdd,
  mathChooseBlocksSub,
  mathDragBlocksSub,
  bingoArabic,
  completeTheWord,
  chooseTheStretchedLetter,
  chooseTheStretchedWord,
  completeTheStretchedLetter,
  memoryCards,
  completeTheSentence,
  cTNumber,
  cTNumberLine,
  cTNumberSub,
  cTNumberSubLine,
  dDTChange,
  mathChooseBoard,
  clickOnTheFish,
  countTypeNumber,
  addRodNumberLine,
  addBeadNumberLine,
  addRodsType,
  add3beadsType,
  add3rodsChoose,
  chartSubType,
  dragBeadsBoard,
  subRodsChooseNumber,
  addRodDragNumber,
  dragBeadType,
  chooseYourAge,
  chooseYourGender,
  chooseSenses
}

extension TypeExtension on GameTypes {
  String text() {
    switch (this) {
      case GameTypes.dragOut:
        return "Drag Out".toLowerCase();
      case GameTypes.ninePicCards:
        return "nine pic cards".toLowerCase();
      case GameTypes.clickPicture:
        return 'Click the picture'.toLowerCase();
      case GameTypes.clickTheSound:
        return 'Click the sound'.toLowerCase();
      case GameTypes.bingo:
        return 'Bingo'.toLowerCase();
      case GameTypes.sortingCups:
        return 'Sorting Cups'.toLowerCase();
      case GameTypes.sortingPictures:
        return 'Sorting Pictures'.toLowerCase();
      case GameTypes.dice:
        return 'Dice'.toLowerCase();
      case GameTypes.xOut:
        return 'X-Out'.toLowerCase();
      case GameTypes.spelling:
        return 'Spelling'.toLowerCase();
      case GameTypes.tracing:
        return 'trace'.toLowerCase();
      case GameTypes.chooseTheCorrect:
        return 'Choose the Correct'.toLowerCase();
      case GameTypes.video:
        return 'Video'.toLowerCase();
      case GameTypes.dragPicToWord:
        return 'Drag Pic to Word'.toLowerCase();
      case GameTypes.dragWordToPic:
        return 'Drag Word to Pic'.toLowerCase();
      case GameTypes.spellingWord:
        return 'Spelling Word'.toLowerCase();
      case GameTypes.wordFamily:
        return 'word family'.toLowerCase();
      case GameTypes.match:
        return 'Match'.toLowerCase();
      case GameTypes.clickTheWord:
        return 'Click the Word'.toLowerCase();
      case GameTypes.listenAndChoose:
        return 'Listen and Choose'.toLowerCase();
      case GameTypes.sortingCupsUP:
        return 'Sorting cups UP'.toLowerCase();
      case GameTypes.rearrange:
        return 'Rearrange'.toLowerCase();
      case GameTypes.chooseTheSentence:
        return 'Choose the Sentence'.toLowerCase();
      case GameTypes.tracingArabic:
        return 'تتبع بإصبعين'.toLowerCase();
      case GameTypes.clickPictureArabic:
        return 'اضغط علي الصورة'.toLowerCase();
      case GameTypes.clickTheSoundArabic:
        return 'لون الحرف'.toLowerCase();
      case GameTypes.dragOutArabic:
        return 'استبعد'.toLowerCase();
      case GameTypes.repeatCharArabic:
        return 'كرر خلفي'.toLowerCase();
      case GameTypes.chooseCorrectWordArabic:
        return 'اختر الكلمة الصحيحة'.toLowerCase();
      case GameTypes.chooseFormationArabic:
        return 'اختر التشكيل'.toLowerCase();
      case GameTypes.matchingArabic:
        return 'صل'.toLowerCase();
      case GameTypes.sortingCupsArabic:
        return 'صنف'.toLowerCase();
      case GameTypes.chooseTheCorrectCharArabic:
        return 'اخترالحرف الصحيح'.toLowerCase();
      case GameTypes.createWordArabic:
        return 'كون الكلمات'.toLowerCase();
      case GameTypes.mathChooseSticks:
        return 'Math_Choose_Sticks'.toLowerCase();
      case GameTypes.mathChooseBeads:
        return 'math_choose_beads'.toLowerCase();
      case GameTypes.mathChooseBlocks:
        return 'Math_Choose_Blocks'.toLowerCase();
      case GameTypes.mathChooseBeadsNumber:
        return 'Math_Choose_Beads_Number'.toLowerCase();
      case GameTypes.mathChooseBlocksNumber:
        return 'Math_Choose_Blocks_Number'.toLowerCase();
      case GameTypes.mathSortingBlocks:
        return 'Math_Sorting_Blocks'.toLowerCase();
      case GameTypes.mathChooseDomino:
        return 'Math_Choose_Domino'.toLowerCase();
      case GameTypes.mathChooseDominoNumber:
        return 'Math_Choose_Domino_Number'.toLowerCase();
      case GameTypes.mathChooseDominoOE:
        return 'Math_Choose_Domino_OE'.toLowerCase();
      case GameTypes.mathDragDominoOE:
        return 'Math_Drag_Domino_OE'.toLowerCase();
      case GameTypes.mathDragBlocksOE:
        return 'Math_Drag_Blocks_OE'.toLowerCase();
      case GameTypes.mathChooseBeadsOE:
        return 'Math_Choose_Beads_OE'.toLowerCase();
      case GameTypes.mathDragSticks:
        return 'Math_Drag_Sticks'.toLowerCase();
      case GameTypes.mathChooseBlocksAdd:
        return 'Math_Choose_Blocks_Add'.toLowerCase();
      case GameTypes.mathChooseBeadsAdd:
        return 'Math_Choose_Beads_Add'.toLowerCase();
      case GameTypes.mathChooseBlocksAddLine:
        return 'Math_Choose_Blocks_Add_Line'.toLowerCase();
      case GameTypes.mathChooseBeadsAddLine:
        return 'Math_Choose_Beads_Add_Line'.toLowerCase();
      case GameTypes.mathDragBlocksAdd:
        return 'Math_Drag_Blocks_Add'.toLowerCase();
      case GameTypes.mathDragBeadsAdd:
        return 'Math_Drag_Beads_Add'.toLowerCase();
      case GameTypes.mathChooseBlocksSub:
        return 'Math_Choose_Blocks_Sub'.toLowerCase();
      case GameTypes.mathDragBlocksSub:
        return 'Math_Drag_Blocks_Sub'.toLowerCase();
      case GameTypes.bingoArabic:
        return 'Arabic Bingo'.toLowerCase();
      case GameTypes.completeTheWord:
        return 'أكمل الكلمة'.toLowerCase();
      case GameTypes.chooseTheStretchedLetter:
        return 'اختر الحرف الممدود'.toLowerCase();
      case GameTypes.memoryCards:
        return 'Memory Cards'.toLowerCase();
      case GameTypes.completeTheSentence:
        return 'Complete the sentence'.toLowerCase();
      case GameTypes.cTNumber:
        return 'CT_number'.toLowerCase();
      case GameTypes.cTNumberLine:
        return 'CT_number_line'.toLowerCase();
      case GameTypes.dDTChange:
        return 'DDT_change'.toLowerCase();
      case GameTypes.cTNumberSub:
        return 'CT_number_sub'.toLowerCase();
      case GameTypes.cTNumberSubLine:
        return 'CT_number_sub_line'.toLowerCase();
      case GameTypes.mathChooseBoard:
        return 'Math_Choose_Board'.toLowerCase();
      case GameTypes.countTypeNumber:
        return 'Count_Type_Number'.toLowerCase();
      case GameTypes.addRodNumberLine:
        return 'add_rod_number_line';
      case GameTypes.clickOnTheFish:
        return 'اختر السمكة';
      case GameTypes.addBeadNumberLine:
        return 'Add_Bead_Number_Line';
      case GameTypes.addRodsType:
        return 'Add_Rods_Type';
      case GameTypes.add3rodsChoose:
        return 'Add_3rods_Choose';
      case GameTypes.add3beadsType:
        return 'Add_3beads_type';
      case GameTypes.subRodsChooseNumber:
        return 'Sub_Rods_Choose_Number';
      case GameTypes.chartSubType:
        return 'Chart_Sub_Type';
      case GameTypes.dragBeadsBoard:
        return 'Drag_Beads_Board';
      case GameTypes.addRodDragNumber:
        return 'Add_Rod_Drag_Number';
      case GameTypes.dragBeadType:
        return 'Drag_Bead_Type';
      case GameTypes.chooseTheStretchedWord:
        return 'اختر الكلمة التي بها مد';
      case GameTypes.completeTheStretchedLetter:
        return 'أكمل الحرف الممدود';
      case GameTypes.chooseYourAge:
        return 'Choose_Your_Age';
      case GameTypes.chooseYourGender:
        return 'Choose_Your_Gender';
      case GameTypes.chooseSenses:
        return 'Choose_Senses';
    }
  }
}

enum ToolsOfMath { sticks, beads, blocks, domino }

enum SymbolsMath { sum, sub }
