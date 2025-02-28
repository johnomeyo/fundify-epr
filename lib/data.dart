import 'package:fundora/message_model.dart';

final investors = [
  {
    "name": "David Chapelle",
    "location": "London",
    "imageUrl":
        "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80",
  },
  {
    "name": "Sophia Martinez",
    "location": "New York",
    "imageUrl":
        "https://images.unsplash.com/photo-1607746882042-944635dfe10e?q=80",
  },
  {
    'name': 'Jane Doe',
    'location': 'New York',
    'imageUrl':
        'https://plus.unsplash.com/premium_photo-1688821124998-847da5285ce8?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  },
  {
    "name": "John Smith",
    "location": "San Francisco",
    "imageUrl":
        "https://images.unsplash.com/photo-1556157382-97eda2d62296?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  },
];

/// Mock data for messages with whom messages have been exchanged
final List<Message> messages = [
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  )
];
