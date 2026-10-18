/// Every user-facing string, kept in one place (ready for localization).
abstract final class AppStrings {
  static const appName = 'Tawasul';

  // Auth
  static const welcomeTitle = 'Welcome to Tawasul';
  static const welcomeSubtitle =
      'Pick a demo account to jump into the conversation.';
  static const chooseAccount = 'Choose an account';
  static const signInFailed = 'Could not sign in. Please try again.';
  static const signOut = 'Sign out';
  static const signOutFailed = 'Could not sign out. Please try again.';

  // Home tabs
  static const messages = 'Messages';
  static const notifications = 'Notifications';
  static const calls = 'Calls';
  static const contacts = 'Contacts';
  static const newChat = 'New chat';

  // Bottom bar (short labels that fit narrow phones)
  static const navChats = 'Chats';
  static const navAlerts = 'Alerts';
  static const navCalls = 'Calls';
  static const navPeople = 'People';

  // Conversations
  static const stories = 'Stories';
  static const yourStory = 'Your story';
  static const noConversationsTitle = 'No conversations yet';
  static const noConversationsMessage =
      'Tap the + button to start chatting with someone.';
  static const noMessagesYet = 'No messages yet';
  static const unnamedChat = 'Unnamed chat';
  static const unknownUser = 'Unknown';

  // Chat
  static const typeMessage = 'Message…';
  static const sayHelloTitle = 'Say hello 👋';
  static const sayHelloMessage = 'Send the first message to start the chat.';
  static const typing = 'typing';
  static const online = 'Online';
  static const offline = 'Offline';
  static const connecting = 'Connecting…';
  static const lastSeen = 'Last seen';
  static const members = 'members';
  static const watching = 'online';
  static const sendMessage = 'Send message';
  static const attach = 'Attach';
  static const videoCall = 'Video call';
  static const voiceCall = 'Voice call';
  static const back = 'Back';

  // Dates
  static const today = 'Today';
  static const yesterday = 'Yesterday';

  // Contacts
  static const noContactsTitle = 'No contacts found';
  static const noContactsMessage = 'Invite friends to Tawasul to chat here.';
  static const startConversation = 'Start a conversation';
  static const openChatFailed = 'Could not open the conversation.';

  // Placeholders
  static const notificationsEmptyTitle = 'You’re all caught up';
  static const notificationsEmptyMessage =
      'New mentions and reactions will show up here.';
  static const callsEmptyTitle = 'No recent calls';
  static const callsEmptyMessage =
      'Voice and video calls you make will appear here.';
  static const comingSoon = 'Coming soon ✨';

  // Profile
  static const profile = 'Profile';
  static const appearance = 'Appearance';
  static const themeSystem = 'System';
  static const themeLight = 'Light';
  static const themeDark = 'Dark';
  static const account = 'Account';
  static const noName = 'No name';

  // Errors
  static const errorTitle = 'Something went wrong';
  static const errorMessage = 'Please check your connection and try again.';
  static const retry = 'Try again';
  static const pageNotFound = 'Page not found';
}
