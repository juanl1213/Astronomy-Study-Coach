import { useState } from "react";
import { Button } from "./components/ui/button";
import { 
  Home, 
  BookOpen, 
  Target, 
  Brain, 
  Star, 
  TrendingUp,
  Menu,
  X,
  BookMarked,
  ExternalLink,
  Settings as SettingsIcon,
  LogOut,
  User,
  MessageSquare
} from "lucide-react";
import { Dashboard } from "./components/Dashboard";
import { StudyTopics } from "./components/StudyTopics";
import { Quiz } from "./components/Quiz";
import { Flashcards } from "./components/Flashcards";
import { ConstellationGuide } from "./components/ConstellationGuide";
import { Progress } from "./components/Progress";
import { Achievements } from "./components/Achievements";
import { Statistics } from "./components/Statistics";
import { Glossary } from "./components/Glossary";
import { Resources } from "./components/Resources";
import { Login } from "./components/Login";
import { SignUp } from "./components/SignUp";
import { Settings } from "./components/Settings";
import { AIChatbot } from "./components/AIChatbot";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "./components/ui/dropdown-menu";
import { Avatar, AvatarFallback } from "./components/ui/avatar";

// Lesson components
import { SolarSystemLesson } from "./components/lessons/SolarSystemLesson";
import { PlanetsLesson } from "./components/lessons/PlanetsLesson";
import { StarsLesson } from "./components/lessons/StarsLesson";
import { GalaxiesLesson } from "./components/lessons/GalaxiesLesson";
import { CosmologyLesson } from "./components/lessons/CosmologyLesson";
import { ExoplanetsLesson } from "./components/lessons/ExoplanetsLesson";
import { BlackHolesLesson } from "./components/lessons/BlackHolesLesson";
import { NebulaeLesson } from "./components/lessons/NebulaeLesson";
import { AsteroidsLesson } from "./components/lessons/AsteroidsLesson";
import { SpaceExplorationLesson } from "./components/lessons/SpaceExplorationLesson";

// Quiz components
import { QuizHome } from "./components/quizzes/QuizHome";
import { QuizHistory } from "./components/quizzes/QuizHistory";

type Section = string;

export default function App() {
  const [currentSection, setCurrentSection] = useState<Section>('login');
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [userEmail, setUserEmail] = useState("");
  const [userName, setUserName] = useState("");

  const navigation = [
    { id: 'dashboard', label: 'Dashboard', icon: Home },
    { id: 'study', label: 'Study Topics', icon: BookOpen },
    { id: 'quiz', label: 'Quizzes', icon: Target },
    { id: 'flashcards', label: 'Flashcards', icon: Brain },
    { id: 'constellations', label: 'Constellations', icon: Star },
    { id: 'ai-chatbot', label: 'AI Chatbot', icon: MessageSquare },
    { id: 'progress', label: 'Progress', icon: TrendingUp },
    { id: 'settings', label: 'Settings', icon: SettingsIcon }
  ];

  const handleNavigate = (section: string) => {
    setCurrentSection(section);
    setIsMobileMenuOpen(false);
    window.scrollTo(0, 0);
  };

  const handleLogin = (email: string) => {
    setIsAuthenticated(true);
    setUserEmail(email);
    setUserName(email.split('@')[0]);
  };

  const handleSignUp = (email: string, name: string) => {
    setIsAuthenticated(true);
    setUserEmail(email);
    setUserName(name);
  };

  const handleLogout = () => {
    setIsAuthenticated(false);
    setUserEmail("");
    setUserName("");
    setCurrentSection('login');
  };

  const renderContent = () => {
    // Auth pages
    if (currentSection === 'login') {
      return <Login onNavigate={handleNavigate} onLogin={handleLogin} />;
    }
    if (currentSection === 'signup') {
      return <SignUp onNavigate={handleNavigate} onSignUp={handleSignUp} />;
    }

    // Protected routes - require authentication
    if (!isAuthenticated) {
      return <Login onNavigate={handleNavigate} onLogin={handleLogin} />;
    }

    // Settings page
    if (currentSection === 'settings') {
      return <Settings onNavigate={handleNavigate} userEmail={userEmail} userName={userName} />;
    }

    // Lesson pages
    if (currentSection === 'lesson-solar-system') {
      return <SolarSystemLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-planets') {
      return <PlanetsLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-stars') {
      return <StarsLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-galaxies') {
      return <GalaxiesLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-cosmology') {
      return <CosmologyLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-exoplanets') {
      return <ExoplanetsLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-black-holes') {
      return <BlackHolesLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-nebulae') {
      return <NebulaeLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-asteroids') {
      return <AsteroidsLesson onNavigate={handleNavigate} />;
    }
    if (currentSection === 'lesson-space-exploration') {
      return <SpaceExplorationLesson onNavigate={handleNavigate} />;
    }

    // Quiz pages
    if (currentSection.startsWith('quiz-') && currentSection !== 'quiz-history') {
      return <Quiz onNavigate={handleNavigate} quizType={currentSection.replace('quiz-', '')} />;
    }
    if (currentSection === 'quiz-history') {
      return <QuizHistory onNavigate={handleNavigate} />;
    }

    // Main navigation pages
    switch (currentSection) {
      case 'dashboard':
        return <Dashboard onNavigate={handleNavigate} />;
      case 'study':
        return <StudyTopics onNavigate={handleNavigate} />;
      case 'quiz':
        return <QuizHome onNavigate={handleNavigate} />;
      case 'flashcards':
        return <Flashcards onNavigate={handleNavigate} />;
      case 'constellations':
        return <ConstellationGuide onNavigate={handleNavigate} />;
      case 'ai-chatbot':
        return <AIChatbot onNavigate={handleNavigate} />;
      case 'progress':
        return <Progress onNavigate={handleNavigate} />;
      case 'achievements':
        return <Achievements onNavigate={handleNavigate} />;
      case 'statistics':
        return <Statistics onNavigate={handleNavigate} />;
      case 'glossary':
        return <Glossary onNavigate={handleNavigate} />;
      case 'resources':
        return <Resources onNavigate={handleNavigate} />;
      default:
        return <Dashboard onNavigate={handleNavigate} />;
    }
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      {isAuthenticated && (
        <header className="sticky top-0 z-50 border-b border-border bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
          <div className="flex h-16 items-center justify-between px-4 md:px-6">
            <div className="flex items-center space-x-2 cursor-pointer group" onClick={() => handleNavigate('dashboard')}>
              <div className="w-8 h-8 bg-gradient-to-br from-indigo-600 to-cyan-600 rounded-lg flex items-center justify-center shadow-lg shadow-indigo-500/20 group-hover:shadow-indigo-500/30 transition-all">
                <Star className="h-5 w-5 text-white" />
              </div>
              <h1 className="text-xl font-bold bg-gradient-to-r from-indigo-400 to-cyan-400 bg-clip-text text-transparent">
                Astronomy Study Coach
              </h1>
            </div>
            
            {/* Desktop Navigation */}
            <nav className="hidden md:flex items-center space-x-1">
            {navigation.map((item) => (
              <Button
                key={item.id}
                variant={currentSection === item.id ? "default" : "ghost"}
                size="sm"
                onClick={() => handleNavigate(item.id)}
                className="flex items-center space-x-2"
              >
                <item.icon className="h-4 w-4" />
                <span>{item.label}</span>
              </Button>
            ))}
            <Button
              variant="ghost"
              size="sm"
              onClick={() => handleNavigate('glossary')}
              className="flex items-center space-x-2"
            >
              <BookMarked className="h-4 w-4" />
              <span>Glossary</span>
            </Button>
            <Button
              variant="ghost"
              size="sm"
              onClick={() => handleNavigate('resources')}
              className="flex items-center space-x-2"
            >
              <ExternalLink className="h-4 w-4" />
              <span>Resources</span>
            </Button>

            {/* User Menu */}
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="sm" className="flex items-center space-x-2">
                  <Avatar className="h-7 w-7">
                    <AvatarFallback className="bg-primary/10 text-primary">
                      {userName.charAt(0).toUpperCase()}
                    </AvatarFallback>
                  </Avatar>
                  <span className="hidden lg:inline">{userName}</span>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-56">
                <DropdownMenuLabel>My Account</DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem onSelect={() => handleNavigate('settings')}>
                  <SettingsIcon className="mr-2 h-4 w-4" />
                  Settings
                </DropdownMenuItem>
                <DropdownMenuItem onSelect={() => handleNavigate('progress')}>
                  <TrendingUp className="mr-2 h-4 w-4" />
                  My Progress
                </DropdownMenuItem>
                <DropdownMenuSeparator />
                <DropdownMenuItem onSelect={handleLogout} className="text-destructive">
                  <LogOut className="mr-2 h-4 w-4" />
                  Log Out
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </nav>

          {/* Mobile Menu Button */}
          <div className="md:hidden flex items-center space-x-2">
            {/* Mobile User Menu */}
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="sm">
                  <Avatar className="h-7 w-7">
                    <AvatarFallback className="bg-primary/10 text-primary">
                      {userName.charAt(0).toUpperCase()}
                    </AvatarFallback>
                  </Avatar>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-56">
                <DropdownMenuLabel>{userName}</DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem onSelect={() => handleNavigate('settings')}>
                  <SettingsIcon className="mr-2 h-4 w-4" />
                  Settings
                </DropdownMenuItem>
                <DropdownMenuItem onSelect={handleLogout} className="text-destructive">
                  <LogOut className="mr-2 h-4 w-4" />
                  Log Out
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>

            <Button
              variant="ghost"
              size="sm"
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
            >
              {isMobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
            </Button>
          </div>
        </div>

        {/* Mobile Navigation */}
        {isMobileMenuOpen && (
          <div className="md:hidden border-t bg-background">
            <nav className="grid grid-cols-2 gap-2 p-4">
              {navigation.map((item) => (
                <Button
                  key={item.id}
                  variant={currentSection === item.id ? "default" : "outline"}
                  size="sm"
                  onClick={() => handleNavigate(item.id)}
                  className="flex items-center space-x-2 justify-start"
                >
                  <item.icon className="h-4 w-4" />
                  <span>{item.label}</span>
                </Button>
              ))}
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleNavigate('glossary')}
                className="flex items-center space-x-2 justify-start"
              >
                <BookMarked className="h-4 w-4" />
                <span>Glossary</span>
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={() => handleNavigate('resources')}
                className="flex items-center space-x-2 justify-start"
              >
                <ExternalLink className="h-4 w-4" />
                <span>Resources</span>
              </Button>
            </nav>
          </div>
        )}
        </header>
      )}

      {/* Main Content */}
      <main className={isAuthenticated ? "container mx-auto px-4 py-6 md:px-6 md:py-8" : ""}>
        {renderContent()}
      </main>

      {/* Footer */}
      {isAuthenticated && (
        <footer className="border-t border-border bg-gradient-to-b from-transparent to-indigo-950/10 mt-12">
        <div className="container mx-auto px-4 py-6 md:px-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <div className="flex items-center space-x-2 mb-2">
                <div className="w-6 h-6 bg-gradient-to-br from-indigo-600 to-cyan-600 rounded flex items-center justify-center shadow-md shadow-indigo-500/20">
                  <Star className="h-4 w-4 text-white" />
                </div>
                <span className="font-medium">Astronomy Study Coach</span>
              </div>
              <p className="text-sm text-muted-foreground">
                Your personal guide to exploring the wonders of the universe through interactive learning.
              </p>
            </div>
            
            <div>
              <h4 className="font-medium mb-2">Study Resources</h4>
              <ul className="space-y-1 text-sm text-muted-foreground">
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('study')}>
                  Interactive Lessons
                </li>
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('quiz')}>
                  Practice Quizzes
                </li>
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('flashcards')}>
                  Flashcard System
                </li>
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('constellations')}>
                  Constellation Guide
                </li>
              </ul>
            </div>
            
            <div>
              <h4 className="font-medium mb-2">Features</h4>
              <ul className="space-y-1 text-sm text-muted-foreground">
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('progress')}>
                  Progress Tracking
                </li>
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('achievements')}>
                  Achievement System
                </li>
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('glossary')}>
                  Astronomy Glossary
                </li>
                <li className="cursor-pointer hover:text-foreground" onClick={() => handleNavigate('resources')}>
                  Learning Resources
                </li>
              </ul>
            </div>
          </div>
          
          <div className="border-t mt-6 pt-6 text-center">
            <p className="text-sm text-muted-foreground">
              Start your journey through the cosmos today. The universe awaits your discovery!
            </p>
          </div>
        </div>
        </footer>
      )}
    </div>
  );
}
