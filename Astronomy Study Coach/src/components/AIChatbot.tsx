import { useState, useRef, useEffect } from "react";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Card } from "./ui/card";
import { ScrollArea } from "./ui/scroll-area";
import { Avatar, AvatarFallback } from "./ui/avatar";
import { Badge } from "./ui/badge";
import { 
  Bot, 
  Send, 
  Sparkles, 
  ArrowLeft,
  MessageSquare,
  Lightbulb,
  Rocket,
  BookOpen,
  Target,
  Brain,
  Star
} from "lucide-react";

interface Message {
  id: string;
  content: string;
  role: 'user' | 'assistant';
  timestamp: Date;
}

interface AIChatbotProps {
  onNavigate: (section: string) => void;
}

export function AIChatbot({ onNavigate }: AIChatbotProps) {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: '1',
      content: "Hello! I'm your Astronomy Study AI Assistant. I'm here to help you learn about space, answer your astronomy questions, and guide you through your cosmic journey. What would you like to explore today?",
      role: 'assistant',
      timestamp: new Date()
    }
  ]);
  const [input, setInput] = useState("");
  const [isTyping, setIsTyping] = useState(false);
  const scrollAreaRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  const suggestedQuestions = [
    "What is a black hole?",
    "How far is the nearest star?",
    "Explain the Big Bang theory",
    "What are exoplanets?",
    "How do stars form?",
    "What is dark matter?"
  ];

  // AI response generator with astronomy knowledge
  const generateResponse = (question: string): string => {
    const lowerQuestion = question.toLowerCase();

    // Black hole questions
    if (lowerQuestion.includes('black hole')) {
      return "A black hole is a region in space where gravity is so strong that nothing, not even light, can escape from it. They form when massive stars collapse at the end of their life cycle. There are different types: stellar black holes (formed from collapsed stars), supermassive black holes (found at galaxy centers), and intermediate black holes. The boundary around a black hole is called the event horizon - once something crosses this point, it cannot escape. Would you like to learn more about how black holes affect nearby objects?";
    }

    // Star questions
    if (lowerQuestion.includes('star') && (lowerQuestion.includes('form') || lowerQuestion.includes('born'))) {
      return "Stars form in giant clouds of gas and dust called nebulae. When a region of the nebula becomes dense enough, gravity causes it to collapse. As the material compresses, it heats up, and eventually the core becomes hot enough (around 10 million degrees Celsius) for nuclear fusion to begin. This fusion of hydrogen into helium releases enormous energy, and a star is born! Our Sun formed this way about 4.6 billion years ago. The process can take millions of years from start to finish.";
    }

    // Planet questions
    if (lowerQuestion.includes('planet') || lowerQuestion.includes('solar system')) {
      return "Our solar system has 8 planets orbiting the Sun: Mercury, Venus, Earth, Mars (the rocky terrestrial planets), Jupiter, Saturn, Uranus, and Neptune (the gas and ice giants). Each planet has unique characteristics - for example, Jupiter is the largest and has a giant storm called the Great Red Spot, while Saturn is famous for its spectacular ring system. Would you like to explore a specific planet in detail?";
    }

    // Exoplanet questions
    if (lowerQuestion.includes('exoplanet')) {
      return "Exoplanets are planets that orbit stars other than our Sun. Scientists have discovered over 5,000 confirmed exoplanets! We find them using several methods: the transit method (detecting tiny dips in a star's brightness when a planet passes in front), the radial velocity method (detecting wobbles in a star's motion), and direct imaging. Some exoplanets are in the 'habitable zone' where liquid water could exist. The study of exoplanets helps us understand if Earth-like worlds are common in the universe!";
    }

    // Big Bang questions
    if (lowerQuestion.includes('big bang')) {
      return "The Big Bang theory describes how the universe began approximately 13.8 billion years ago. It wasn't an explosion in space, but rather an expansion of space itself from an incredibly hot, dense point. In the first fractions of a second, the universe expanded rapidly (inflation), then cooled enough for subatomic particles to form, then atoms (mostly hydrogen and helium). Evidence for the Big Bang includes the cosmic microwave background radiation, the abundance of light elements, and the fact that galaxies are moving away from each other. It's the best explanation we have for the origin and evolution of our universe!";
    }

    // Dark matter questions
    if (lowerQuestion.includes('dark matter')) {
      return "Dark matter is a mysterious form of matter that doesn't emit, absorb, or reflect light, making it invisible to telescopes. However, we know it exists because of its gravitational effects on visible matter. Galaxies rotate faster than they should based on visible matter alone, and galaxy clusters are held together by more gravity than we can see. Scientists estimate that dark matter makes up about 27% of the universe's mass-energy content, while ordinary matter is only about 5%. We still don't know what dark matter is made of - it's one of the biggest mysteries in modern astronomy!";
    }

    // Galaxy questions
    if (lowerQuestion.includes('galaxy') || lowerQuestion.includes('galaxies')) {
      return "Galaxies are massive systems of stars, gas, dust, and dark matter bound together by gravity. There are billions of galaxies in the observable universe! They come in different shapes: spiral galaxies (like our Milky Way) have rotating arms, elliptical galaxies are more spherical, and irregular galaxies have no defined shape. Our Milky Way galaxy contains 200-400 billion stars and is about 100,000 light-years across. The nearest large galaxy to us is Andromeda, about 2.5 million light-years away. What aspect of galaxies interests you most?";
    }

    // Distance questions
    if (lowerQuestion.includes('nearest star') || lowerQuestion.includes('closest star')) {
      return "The nearest star to Earth (excluding the Sun) is Proxima Centauri, part of the Alpha Centauri star system. It's about 4.24 light-years away, which means light from this star takes 4.24 years to reach us! That's roughly 40 trillion kilometers (25 trillion miles). Even traveling at the speed of our fastest spacecraft, it would take tens of thousands of years to get there. Interestingly, Proxima Centauri has at least one confirmed exoplanet, called Proxima Centauri b, which orbits in the star's habitable zone!";
    }

    // Moon questions
    if (lowerQuestion.includes('moon')) {
      return "The Moon is Earth's only natural satellite, orbiting our planet at an average distance of 384,400 km (238,855 miles). It formed about 4.5 billion years ago, likely from debris after a Mars-sized object collided with Earth. The Moon's phases occur because we see different amounts of its sunlit side as it orbits Earth. It takes about 27.3 days to orbit Earth and the same time to rotate once, which is why we always see the same face of the Moon. The Moon's gravity causes ocean tides on Earth and has been gradually slowing Earth's rotation over billions of years.";
    }

    // Constellation questions
    if (lowerQuestion.includes('constellation')) {
      return "Constellations are patterns of stars in the night sky that humans have recognized and named throughout history. There are 88 officially recognized constellations today. They're useful for navigation and organizing our view of the sky. Important to note: the stars in a constellation usually aren't physically close to each other - they just appear near each other from our viewpoint on Earth. Famous constellations include Orion (the hunter), Ursa Major (containing the Big Dipper), and the zodiac constellations. Different cultures have created different constellation patterns from the same stars!";
    }

    // Nebula questions
    if (lowerQuestion.includes('nebula') || lowerQuestion.includes('nebulae')) {
      return "Nebulae are vast clouds of gas and dust in space. They come in several types: emission nebulae glow with their own light (excited by nearby stars), reflection nebulae reflect light from nearby stars, and dark nebulae block light from behind. Nebulae are stellar nurseries - new stars form within them. When massive stars die, they can create planetary nebulae (from medium stars) or supernova remnants (from massive stars). The famous Orion Nebula, visible to the naked eye, is a stellar nursery about 1,344 light-years away where new stars are being born right now!";
    }

    // Default educational response
    return "That's a great question! While I'm focused on astronomy topics, I'd love to help you explore the universe. Here are some fascinating topics we can discuss: the lifecycle of stars, the formation of our solar system, black holes and their mysteries, the search for exoplanets, galaxy types and evolution, the Big Bang theory, dark matter and dark energy, space exploration missions, or astronomical observations and telescope technology. What interests you most?";
  };

  const handleSend = async () => {
    if (!input.trim()) return;

    const userMessage: Message = {
      id: Date.now().toString(),
      content: input,
      role: 'user',
      timestamp: new Date()
    };

    setMessages(prev => [...prev, userMessage]);
    setInput("");
    setIsTyping(true);

    // Simulate AI thinking time
    setTimeout(() => {
      const response = generateResponse(input);
      const assistantMessage: Message = {
        id: (Date.now() + 1).toString(),
        content: response,
        role: 'assistant',
        timestamp: new Date()
      };

      setMessages(prev => [...prev, assistantMessage]);
      setIsTyping(false);
    }, 1000 + Math.random() * 1000);
  };

  const handleSuggestedQuestion = (question: string) => {
    setInput(question);
    inputRef.current?.focus();
  };

  useEffect(() => {
    if (scrollAreaRef.current) {
      const scrollContainer = scrollAreaRef.current.querySelector('[data-radix-scroll-area-viewport]');
      if (scrollContainer) {
        scrollContainer.scrollTop = scrollContainer.scrollHeight;
      }
    }
  }, [messages, isTyping]);

  return (
    <div className="min-h-screen pb-8">
      {/* Header */}
      <div className="mb-6">
        <Button
          variant="ghost"
          onClick={() => onNavigate('dashboard')}
          className="mb-4"
        >
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Dashboard
        </Button>
        
        <div className="flex items-center space-x-3 mb-2">
          <div className="relative">
            <div className="w-12 h-12 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center shadow-lg shadow-indigo-500/30">
              <Bot className="h-7 w-7 text-white" />
            </div>
            <div className="absolute -top-1 -right-1 w-4 h-4 bg-green-500 rounded-full border-2 border-background animate-pulse"></div>
          </div>
          <div>
            <h1 className="bg-gradient-to-r from-indigo-400 to-purple-400 bg-clip-text text-transparent">
              AI Study Assistant
            </h1>
            <p className="text-muted-foreground text-sm">Your personal astronomy tutor</p>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Chat Area */}
        <div className="lg:col-span-2">
          <Card className="border-indigo-500/20 bg-card/50 backdrop-blur-sm shadow-lg">
            <div className="p-4 border-b border-border bg-gradient-to-r from-indigo-950/20 to-purple-950/20">
              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-2">
                  <MessageSquare className="h-5 w-5 text-indigo-400" />
                  <span>Chat Session</span>
                </div>
                <Badge variant="secondary" className="bg-indigo-500/10 text-indigo-400 border-indigo-500/20">
                  <Sparkles className="h-3 w-3 mr-1" />
                  AI Powered
                </Badge>
              </div>
            </div>

            {/* Messages */}
            <ScrollArea ref={scrollAreaRef} className="h-[500px] p-4">
              <div className="space-y-4">
                {messages.map((message) => (
                  <div
                    key={message.id}
                    className={`flex ${message.role === 'user' ? 'justify-end' : 'justify-start'}`}
                  >
                    <div className={`flex ${message.role === 'user' ? 'flex-row-reverse' : 'flex-row'} items-start space-x-3 max-w-[85%]`}>
                      <Avatar className={`h-8 w-8 ${message.role === 'assistant' ? 'mt-1' : 'mt-1'}`}>
                        <AvatarFallback className={message.role === 'user' ? 'bg-cyan-500/20 text-cyan-400' : 'bg-indigo-500/20 text-indigo-400'}>
                          {message.role === 'user' ? 'U' : <Bot className="h-4 w-4" />}
                        </AvatarFallback>
                      </Avatar>
                      <div className={`${message.role === 'user' ? 'mr-3' : 'ml-3'}`}>
                        <div
                          className={`rounded-2xl px-4 py-3 ${
                            message.role === 'user'
                              ? 'bg-gradient-to-br from-cyan-600 to-cyan-700 text-white'
                              : 'bg-gradient-to-br from-indigo-950/40 to-purple-950/40 border border-indigo-500/20'
                          }`}
                        >
                          <p className="whitespace-pre-wrap">{message.content}</p>
                        </div>
                        <p className="text-xs text-muted-foreground mt-1 px-2">
                          {message.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                        </p>
                      </div>
                    </div>
                  </div>
                ))}

                {isTyping && (
                  <div className="flex justify-start">
                    <div className="flex items-start space-x-3 max-w-[85%]">
                      <Avatar className="h-8 w-8 mt-1">
                        <AvatarFallback className="bg-indigo-500/20 text-indigo-400">
                          <Bot className="h-4 w-4" />
                        </AvatarFallback>
                      </Avatar>
                      <div className="ml-3">
                        <div className="rounded-2xl px-4 py-3 bg-gradient-to-br from-indigo-950/40 to-purple-950/40 border border-indigo-500/20">
                          <div className="flex space-x-1">
                            <div className="w-2 h-2 bg-indigo-400 rounded-full animate-bounce" style={{ animationDelay: '0ms' }}></div>
                            <div className="w-2 h-2 bg-indigo-400 rounded-full animate-bounce" style={{ animationDelay: '150ms' }}></div>
                            <div className="w-2 h-2 bg-indigo-400 rounded-full animate-bounce" style={{ animationDelay: '300ms' }}></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            </ScrollArea>

            {/* Input Area */}
            <div className="p-4 border-t border-border bg-gradient-to-r from-indigo-950/10 to-purple-950/10">
              <div className="flex space-x-2">
                <Input
                  ref={inputRef}
                  value={input}
                  onChange={(e) => setInput(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && handleSend()}
                  placeholder="Ask me anything about astronomy..."
                  className="flex-1 bg-background/50 border-indigo-500/20 focus:border-indigo-500/40"
                  disabled={isTyping}
                />
                <Button 
                  onClick={handleSend}
                  disabled={!input.trim() || isTyping}
                  className="bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700"
                >
                  <Send className="h-4 w-4" />
                </Button>
              </div>
            </div>
          </Card>
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Suggested Questions */}
          <Card className="border-indigo-500/20 bg-card/50 backdrop-blur-sm p-5">
            <div className="flex items-center space-x-2 mb-4">
              <Lightbulb className="h-5 w-5 text-yellow-400" />
              <h3>Suggested Questions</h3>
            </div>
            <div className="space-y-2">
              {suggestedQuestions.map((question, index) => (
                <Button
                  key={index}
                  variant="outline"
                  className="w-full justify-start text-left h-auto py-3 px-4 border-indigo-500/20 hover:bg-indigo-500/10 hover:border-indigo-500/40"
                  onClick={() => handleSuggestedQuestion(question)}
                >
                  <span className="text-sm">{question}</span>
                </Button>
              ))}
            </div>
          </Card>

          {/* Quick Actions */}
          <Card className="border-cyan-500/20 bg-card/50 backdrop-blur-sm p-5">
            <div className="flex items-center space-x-2 mb-4">
              <Rocket className="h-5 w-5 text-cyan-400" />
              <h3>Quick Actions</h3>
            </div>
            <div className="space-y-2">
              <Button
                variant="outline"
                className="w-full justify-start border-cyan-500/20 hover:bg-cyan-500/10 hover:border-cyan-500/40"
                onClick={() => onNavigate('study')}
              >
                <BookOpen className="mr-2 h-4 w-4" />
                Browse Study Topics
              </Button>
              <Button
                variant="outline"
                className="w-full justify-start border-cyan-500/20 hover:bg-cyan-500/10 hover:border-cyan-500/40"
                onClick={() => onNavigate('quiz')}
              >
                <Target className="mr-2 h-4 w-4" />
                Take a Quiz
              </Button>
              <Button
                variant="outline"
                className="w-full justify-start border-cyan-500/20 hover:bg-cyan-500/10 hover:border-cyan-500/40"
                onClick={() => onNavigate('flashcards')}
              >
                <Brain className="mr-2 h-4 w-4" />
                Study Flashcards
              </Button>
              <Button
                variant="outline"
                className="w-full justify-start border-cyan-500/20 hover:bg-cyan-500/10 hover:border-cyan-500/40"
                onClick={() => onNavigate('constellations')}
              >
                <Star className="mr-2 h-4 w-4" />
                Constellation Guide
              </Button>
            </div>
          </Card>

          {/* Tips */}
          <Card className="border-purple-500/20 bg-gradient-to-br from-purple-950/20 to-indigo-950/20 p-5">
            <h3 className="mb-3">💡 Tips for Better Learning</h3>
            <ul className="space-y-2 text-sm text-muted-foreground">
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>Ask specific questions for detailed answers</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>Request examples or analogies for complex topics</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>Follow up with "explain more" for deeper understanding</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>Ask about current space missions and discoveries</span>
              </li>
            </ul>
          </Card>
        </div>
      </div>
    </div>
  );
}
