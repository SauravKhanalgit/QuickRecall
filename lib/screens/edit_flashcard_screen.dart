import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:startapp_sdk/startapp.dart';
import '../models/flashcard.dart';

class EditQUICKRECALLcreen extends StatefulWidget {
  final Flashcard? flashcard;
  final int? index;
  const EditQUICKRECALLcreen({super.key, this.flashcard, this.index});

  @override
  State<EditQUICKRECALLcreen> createState() => _EditQUICKRECALLcreenState();
}

class _EditQUICKRECALLcreenState extends State<EditQUICKRECALLcreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final Box<Flashcard> flashcardBox = Hive.box<Flashcard>('QUICKRECALL');
  final _formKey = GlobalKey<FormState>();
  bool _isEdited = false;
  final FocusNode _questionFocus = FocusNode();
  final FocusNode _answerFocus = FocusNode();
  final startAppSdk = StartAppSdk();
  StartAppBannerAd? bannerAd;
  StartAppInterstitialAd? interstitialAd;
  // Common flashcard questions with suggested answers
  final List<Map<String, String>> _questionSuggestions = [
    {'question': 'What is the capital of France?', 'answer': 'Paris'},
    {
      'question': 'What is the largest planet in our solar system?',
      'answer': 'Jupiter',
    },
    {'question': 'Who painted the Mona Lisa?', 'answer': 'Leonardo da Vinci'},
    {'question': 'What is the chemical symbol for gold?', 'answer': 'Au'},
    {'question': 'In which year did World War II end?', 'answer': '1945'},
    {'question': 'What is the square root of 64?', 'answer': '8'},
    {'question': 'Who wrote "To Kill a Mockingbird"?', 'answer': 'Harper Lee'},
    {
      'question': 'What is the main component of the Sun?',
      'answer': 'Hydrogen',
    },
    {'question': 'How many continents are there?', 'answer': '7'},
    {'question': 'What is the longest river in the world?', 'answer': 'Nile'},
    {'question': 'Who discovered penicillin?', 'answer': 'Alexander Fleming'},
    {'question': 'What is the currency of Japan?', 'answer': 'Yen'},
    {'question': 'How many bones are in the human body?', 'answer': '206'},
    {
      'question': 'What is the largest ocean on Earth?',
      'answer': 'Pacific Ocean',
    },
    {
      'question': 'Who was the first president of the United States?',
      'answer': 'George Washington',
    },
    {
      'question': 'What is the boiling point of water in Celsius?',
      'answer': '100°C',
    },
    {'question': 'Which planet is known as the Red Planet?', 'answer': 'Mars'},
    {
      'question': 'What is the largest mammal on Earth?',
      'answer': 'Blue Whale',
    },
    {
      'question': 'Who developed the theory of relativity?',
      'answer': 'Albert Einstein',
    },
    {'question': 'What is the capital of Canada?', 'answer': 'Ottawa'},
    {
      'question': 'How many elements are in the periodic table?',
      'answer': '118',
    },
    {'question': 'What is the fastest land animal?', 'answer': 'Cheetah'},
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'answer': 'William Shakespeare',
    },
    {
      'question': 'What is the tallest mountain in the world?',
      'answer': 'Mount Everest',
    },
    {
      'question': 'What is the largest desert in the world?',
      'answer': 'Sahara Desert',
    },
    {
      'question': 'Who invented the telephone?',
      'answer': 'Alexander Graham Bell',
    },
    {
      'question': 'What is the currency of the European Union?',
      'answer': 'Euro',
    },
    {'question': 'How many planets are in our solar system?', 'answer': '8'},
    {
      'question': 'What is the smallest country in the world?',
      'answer': 'Vatican City',
    },
    {
      'question': 'Who was the first person to walk on the moon?',
      'answer': 'Neil Armstrong',
    },
    {'question': 'What is the chemical formula for water?', 'answer': 'H₂O'},
    {'question': 'Which country has the most population?', 'answer': 'China'},
    {
      'question': 'What is the largest organ in the human body?',
      'answer': 'Skin',
    },
    {
      'question': 'Who painted "The Starry Night"?',
      'answer': 'Vincent van Gogh',
    },
    {'question': 'What is the capital of Australia?', 'answer': 'Canberra'},
    {'question': 'How many colors are in a rainbow?', 'answer': '7'},
    {
      'question': 'What is the freezing point of water in Fahrenheit?',
      'answer': '32°F',
    },
    {'question': 'Who wrote "1984"?', 'answer': 'George Orwell'},
    {
      'question': 'What is the largest species of shark?',
      'answer': 'Whale Shark',
    },
    {
      'question': 'Which language has the most native speakers?',
      'answer': 'Mandarin Chinese',
    },
    {'question': 'What is the capital of Brazil?', 'answer': 'Brasília'},
    {'question': 'Who composed "Für Elise"?', 'answer': 'Ludwig van Beethoven'},
    {
      'question': 'What is the largest bone in the human body?',
      'answer': 'Femur',
    },
    {'question': 'Which country invented tea?', 'answer': 'China'},
    {
      'question': 'What is the capital of South Africa?',
      'answer':
          'Pretoria (executive), Cape Town (legislative), Bloemfontein (judicial)',
    },
    {'question': 'Who discovered gravity?', 'answer': 'Isaac Newton'},
    {
      'question': 'What is the largest moon in the solar system?',
      'answer': 'Ganymede',
    },
    {
      'question': 'Which blood type is the universal donor?',
      'answer': 'O negative',
    },
    {'question': 'What is the capital of Egypt?', 'answer': 'Cairo'},
    {'question': 'Who invented the light bulb?', 'answer': 'Thomas Edison'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _questionController.text = widget.flashcard!.question;
      _answerController.text = widget.flashcard!.answer;
    }
    _questionController.addListener(_handleTextChange);
    _answerController.addListener(_handleTextChange);

    _questionFocus.addListener(() {
      if (!_questionFocus.hasFocus && _questionController.text.isEmpty) {
        _showQuestionSuggestions();
      }
      loadInterstitialAd();
      startAppSdk
          .loadBannerAd(StartAppBannerType.BANNER)
          .then((bannerAd) {
            setState(() {
              this.bannerAd = bannerAd;
            });
          })
          .onError<StartAppException>((error, stackTrace) {
            // handle error
            print("Failed to load banner: $error");
          });
    });
  }

  void _handleTextChange() {
    if (!_isEdited) {
      setState(() => _isEdited = true);
    }
  }

  void loadInterstitialAd() {
    startAppSdk
        .loadInterstitialAd()
        .then((interstitialAd) {
          setState(() {
            this.interstitialAd = interstitialAd;
          });
        })
        .onError((ex, stackTrace) {
          debugPrint("Error loading Interstitial ad: ${ex}");
        })
        .onError((error, stackTrace) {
          debugPrint("Error loading Interstitial ad: $error");
        });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Yo, we done it!, interstital')),
    // );
  }

  Future<bool> _onWillPop() async {
    if (!_isEdited) return true;

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard Changes?'),
            content: const Text(
              'You have unsaved changes. Are you sure you want to leave?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  loadInterstitialAd();

                  Navigator.pop(context, true);
                },
                child: const Text(
                  'Discard',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _saveFlashcard() {
    loadInterstitialAd();

    if (!_formKey.currentState!.validate()) return;

    final question = _questionController.text.trim();
    final answer = _answerController.text.trim();

    final newFlashcard = Flashcard(question: question, answer: answer);
    if (widget.index != null) {
      flashcardBox.putAt(widget.index!, newFlashcard);
    } else {
      flashcardBox.add(newFlashcard);

      // Add to suggestions if not already there
      if (!_questionSuggestions.any((q) => q['question'] == question)) {
        setState(() {
          _questionSuggestions.insert(0, {
            'question': question,
            'answer': answer,
          });
        });
      }
    }

    Navigator.pop(context);
    _showSuccessMessage();
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.flashcard == null
              ? 'Flashcard created!'
              : 'Flashcard updated!',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _showQuestionSuggestions() async {
    final selected = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => QuestionSuggestionsBottomSheet(
        suggestions: _questionSuggestions,
        onAddNew: () {
          Navigator.pop(context);
          _questionFocus.requestFocus();
        },
      ),
    );

    if (selected != null) {
      setState(() {
        _questionController.text = selected['question']!;
        _answerController.text = selected['answer']!;
        _isEdited = true;
      });
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _questionFocus.dispose();
    _answerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.flashcard == null ? 'New Flashcard' : 'Edit Flashcard',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.check_rounded),
              onPressed: _saveFlashcard,
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Question',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _showQuestionSuggestions,
                      child: const Text('Browse Suggestions'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _questionController,
                  focusNode: _questionFocus,
                  maxLength: 200,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 3,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'What is the capital of France?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        '${_questionController.text.length}/200',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _questionController.text.length > 180
                              ? colorScheme.error
                              : colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 24,
                      minWidth: 60,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a question';
                    }
                    if (value.trim().length < 5) {
                      return 'Question is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Answer',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _answerController,
                  focusNode: _answerFocus,
                  maxLength: 2500,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 5,
                  minLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Paris is the capital of France',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        '${_answerController.text.length}/2500',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _answerController.text.length > 2450
                              ? colorScheme.error
                              : colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 24,
                      minWidth: 60,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an answer';
                    }
                    if (value.trim().isEmpty) {
                      return 'Answer is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveFlashcard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'SAVE FLASHCARD',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                bannerAd != null
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: StartAppBanner(bannerAd!),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionSuggestionsBottomSheet extends StatefulWidget {
  final List<Map<String, String>> suggestions;
  final VoidCallback onAddNew;

  const QuestionSuggestionsBottomSheet({
    super.key,
    required this.suggestions,
    required this.onAddNew,
  });

  @override
  State<QuestionSuggestionsBottomSheet> createState() =>
      _QuestionSuggestionsBottomSheetState();
}

class _QuestionSuggestionsBottomSheetState
    extends State<QuestionSuggestionsBottomSheet> {
  late List<Map<String, String>> _filteredSuggestions;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = widget.suggestions;
    _searchController.addListener(_filterSuggestions);
  }

  void _filterSuggestions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSuggestions = widget.suggestions.where((item) {
        return item['question']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            'Select a Question',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search questions...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSuggestions.length + 1,
              itemBuilder: (context, index) {
                if (index == _filteredSuggestions.length) {
                  return ListTile(
                    leading: const Icon(Icons.add_circle_outline),
                    title: const Text('Create New Question'),
                    onTap: widget.onAddNew,
                  );
                }
                final item = _filteredSuggestions[index];
                return ListTile(
                  title: Text(item['question']!),
                  subtitle: Text(
                    item['answer']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//
