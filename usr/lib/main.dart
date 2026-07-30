import 'package:flutter/material.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentation App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Enhancing Digital Experience with Mobile Apps',
      content: ['Presented by: Your Name', 'Date: Today'],
      isTitleSlide: true,
    ),
    SlideData(
      title: 'Introduction',
      content: [
        'Mobile apps have become an essential part of daily life.',
        'They provide quick, convenient, and personalized digital services.',
        'Businesses use mobile apps to improve customer engagement and satisfaction.',
      ],
    ),
    SlideData(
      title: 'What is Digital Experience?',
      content: [
        'Digital experience refers to how users interact with digital platforms and services.',
        'It includes:',
        '  • Ease of use',
        '  • Speed and performance',
        '  • Accessibility',
        '  • User satisfaction',
        'A good digital experience builds trust and loyalty.',
      ],
    ),
    SlideData(
      title: 'How Mobile Apps Enhance Digital Experience',
      content: [
        'User-friendly interface (simple navigation)',
        'Personalized content and recommendations',
        'Fast access to services',
        'Push notifications for updates',
        'Secure login and digital payments',
        'Offline access to important features',
      ],
    ),
    SlideData(
      title: 'Key Features of a Great Mobile App',
      content: [
        'Intuitive UI/UX design',
        'Fast loading speed',
        'High security and privacy',
        'Cross-platform compatibility (Android & iOS)',
        'Regular updates and bug fixes',
        'Accessibility for all users',
      ],
    ),
    SlideData(
      title: 'Benefits for Businesses',
      content: [
        'Increased customer engagement',
        'Better brand visibility',
        'Improved customer support',
        'Higher sales and revenue',
        'Valuable customer insights through analytics',
      ],
    ),
    SlideData(
      title: 'Real-World Examples',
      content: [
        'Amazon – Personalized shopping and one-click ordering.',
        'Google Pay – Secure and fast digital payments.',
        'Swiggy – Real-time order tracking and easy ordering.',
        'Netflix – Personalized recommendations and offline viewing.',
      ],
    ),
    SlideData(
      title: 'Challenges',
      content: [
        'Data privacy concerns',
        'Cybersecurity threats',
        'Device compatibility issues',
        'High development and maintenance costs',
        'User retention in a competitive market',
      ],
    ),
    SlideData(
      title: 'Future Trends',
      content: [
        'Artificial Intelligence (AI)',
        'Augmented Reality (AR) and Virtual Reality (VR)',
        'Voice assistants',
        '5G technology',
        'Internet of Things (IoT)',
        'Predictive analytics and personalization',
      ],
    ),
    SlideData(
      title: 'Conclusion',
      content: [
        'Mobile apps play a crucial role in enhancing digital experiences.',
        'They provide convenience, personalization, and security.',
        'Businesses that invest in innovative mobile apps gain a competitive advantage.',
        'The future of mobile apps will be driven by AI, 5G, and immersive technologies.',
      ],
    ),
  ];

  void _nextSlide() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousSlide() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return SlideWidget(slide: _slides[index]);
            },
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton.filledTonal(
                  onPressed: _currentIndex > 0 ? _previousSlide : null,
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 32,
                ),
                Text(
                  'Slide ${_currentIndex + 1} of ${_slides.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton.filledTonal(
                  onPressed: _currentIndex < _slides.length - 1 ? _nextSlide : null,
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final List<String> content;
  final bool isTitleSlide;

  SlideData({
    required this.title,
    required this.content,
    this.isTitleSlide = false,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 64.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            mainAxisAlignment: slide.isTitleSlide ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: slide.isTitleSlide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                slide.title,
                textAlign: slide.isTitleSlide ? TextAlign.center : TextAlign.left,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 48),
              if (slide.isTitleSlide)
                ...slide.content.map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                )
              else
                ...slide.content.map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!text.startsWith('  •'))
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, right: 16.0),
                            child: Icon(Icons.circle, size: 12),
                          ),
                        Expanded(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
