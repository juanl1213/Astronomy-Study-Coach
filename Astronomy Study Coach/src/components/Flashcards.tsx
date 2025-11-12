import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { Badge } from "./ui/badge";
import { Progress } from "./ui/progress";
import { 
  RotateCcw, 
  ArrowRight, 
  ArrowLeft, 
  BookOpen, 
  Star,
  CheckCircle,
  XCircle,
  Shuffle
} from "lucide-react";

interface Flashcard {
  id: number;
  front: string;
  back: string;
  topic: string;
  difficulty: 'Easy' | 'Medium' | 'Hard';
}

interface FlashcardsProps {
  onNavigate: (section: string) => void;
}

export function Flashcards({ onNavigate }: FlashcardsProps) {
  const [currentCard, setCurrentCard] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [knownCards, setKnownCards] = useState<Set<number>>(new Set());
  const [difficultCards, setDifficultCards] = useState<Set<number>>(new Set());
  const [studyMode, setStudyMode] = useState<'all' | 'difficult'>('all');

  const allFlashcards: Flashcard[] = [
    {
      id: 1,
      front: "What is a light-year?",
      back: "A light-year is the distance that light travels in one year in a vacuum, approximately 9.46 trillion kilometers (5.88 trillion miles). It's used to measure vast distances in space.",
      topic: "Basic Concepts",
      difficulty: "Easy"
    },
    {
      id: 2,
      front: "What causes the phases of the Moon?",
      back: "Moon phases are caused by the changing positions of the Moon relative to Earth and the Sun. As the Moon orbits Earth, different portions of its sunlit surface are visible from Earth.",
      topic: "Solar System",
      difficulty: "Easy"
    },
    {
      id: 3,
      front: "What is a supernova?",
      back: "A supernova is the explosive death of a massive star (at least 8 times the mass of our Sun). It occurs when the star's core collapses and then rebounds, creating an extremely bright explosion that can outshine an entire galaxy.",
      topic: "Stellar Evolution",
      difficulty: "Medium"
    },
    {
      id: 4,
      front: "What is dark matter?",
      back: "Dark matter is a form of matter that makes up approximately 27% of the universe. It doesn't emit, absorb, or reflect light, making it invisible to direct observation. Its presence is inferred through its gravitational effects on visible matter.",
      topic: "Cosmology",
      difficulty: "Hard"
    },
    {
      id: 5,
      front: "What is the difference between a planet and a dwarf planet?",
      back: "A planet must: 1) orbit the Sun, 2) have enough mass to be roughly round, and 3) have cleared its orbital neighborhood of other objects. A dwarf planet meets the first two criteria but has not cleared its orbital neighborhood.",
      topic: "Solar System",
      difficulty: "Medium"
    },
    {
      id: 6,
      front: "What is redshift?",
      back: "Redshift is the phenomenon where light from distant objects appears shifted toward longer (redder) wavelengths. It's caused by the expansion of the universe and is key evidence for the Big Bang theory.",
      topic: "Cosmology",
      difficulty: "Hard"
    },
    {
      id: 7,
      front: "What is the main sequence of stellar evolution?",
      back: "The main sequence is the longest phase of a star's life, where it fuses hydrogen into helium in its core. Stars spend about 90% of their lifetime in this stable phase, including our Sun.",
      topic: "Stellar Evolution",
      difficulty: "Medium"
    },
    {
      id: 8,
      front: "What is the Goldilocks Zone?",
      back: "The Goldilocks Zone (or habitable zone) is the region around a star where conditions are 'just right' for liquid water to exist on a planet's surface - not too hot and not too cold.",
      topic: "Exoplanets",
      difficulty: "Easy"
    }
  ];

  const displayCards = studyMode === 'difficult' 
    ? allFlashcards.filter(card => difficultCards.has(card.id))
    : allFlashcards;

  const currentFlashcard = displayCards[currentCard];

  const handleFlip = () => {
    setIsFlipped(!isFlipped);
  };

  const handleNext = () => {
    if (currentCard < displayCards.length - 1) {
      setCurrentCard(currentCard + 1);
      setIsFlipped(false);
    } else {
      setCurrentCard(0);
      setIsFlipped(false);
    }
  };

  const handlePrevious = () => {
    if (currentCard > 0) {
      setCurrentCard(currentCard - 1);
      setIsFlipped(false);
    } else {
      setCurrentCard(displayCards.length - 1);
      setIsFlipped(false);
    }
  };

  const handleKnown = () => {
    setKnownCards(prev => new Set([...prev, currentFlashcard.id]));
    handleNext();
  };

  const handleDifficult = () => {
    setDifficultCards(prev => new Set([...prev, currentFlashcard.id]));
    handleNext();
  };

  const shuffleCards = () => {
    const randomIndex = Math.floor(Math.random() * displayCards.length);
    setCurrentCard(randomIndex);
    setIsFlipped(false);
  };

  const resetProgress = () => {
    setKnownCards(new Set());
    setDifficultCards(new Set());
    setCurrentCard(0);
    setIsFlipped(false);
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'Easy': return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300';
      case 'Medium': return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300';
      case 'Hard': return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300';
      default: return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300';
    }
  };

  if (displayCards.length === 0) {
    return (
      <div className="max-w-2xl mx-auto space-y-6">
        <Card>
          <CardHeader className="text-center">
            <CardTitle>No Cards to Study</CardTitle>
            <CardDescription>
              You haven't marked any cards as difficult yet. Study all cards first to build your difficult cards collection.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Button onClick={() => setStudyMode('all')} className="w-full">
              Study All Cards
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      {/* Header Controls */}
      <Card>
        <CardContent className="p-4">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center space-x-2">
              <BookOpen className="h-5 w-5" />
              <span className="font-medium">Flashcards</span>
              <Badge variant="outline">
                {currentCard + 1} of {displayCards.length}
              </Badge>
            </div>
            <div className="flex space-x-2">
              <Button
                variant={studyMode === 'all' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setStudyMode('all')}
              >
                All Cards
              </Button>
              <Button
                variant={studyMode === 'difficult' ? 'default' : 'outline'}
                size="sm"
                onClick={() => setStudyMode('difficult')}
                disabled={difficultCards.size === 0}
              >
                Difficult ({difficultCards.size})
              </Button>
            </div>
          </div>

          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span>Progress</span>
              <span className="text-muted-foreground">
                {Math.round(((currentCard + 1) / displayCards.length) * 100)}%
              </span>
            </div>
            <Progress value={((currentCard + 1) / displayCards.length) * 100} className="h-2" />
          </div>

          <div className="flex justify-between items-center mt-4">
            <div className="flex space-x-4 text-sm">
              <div className="flex items-center space-x-1">
                <CheckCircle className="h-4 w-4 text-green-600" />
                <span>Known: {knownCards.size}</span>
              </div>
              <div className="flex items-center space-x-1">
                <XCircle className="h-4 w-4 text-red-600" />
                <span>Difficult: {difficultCards.size}</span>
              </div>
            </div>
            <div className="flex space-x-2">
              <Button variant="outline" size="sm" onClick={shuffleCards}>
                <Shuffle className="h-4 w-4" />
              </Button>
              <Button variant="outline" size="sm" onClick={resetProgress}>
                <RotateCcw className="h-4 w-4" />
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Flashcard */}
      <Card className="h-80 cursor-pointer transition-all duration-300 hover:shadow-lg" onClick={handleFlip}>
        <CardHeader className="pb-3">
          <div className="flex justify-between items-center">
            <Badge className={getDifficultyColor(currentFlashcard.difficulty)}>
              {currentFlashcard.difficulty}
            </Badge>
            <Badge variant="outline">{currentFlashcard.topic}</Badge>
          </div>
        </CardHeader>
        <CardContent className="flex items-center justify-center h-48">
          <div className="text-center space-y-4">
            {!isFlipped ? (
              <>
                <Star className="h-8 w-8 mx-auto text-primary" />
                <h3 className="text-lg">{currentFlashcard.front}</h3>
                <p className="text-sm text-muted-foreground">Click to reveal answer</p>
              </>
            ) : (
              <div className="space-y-3">
                <h3 className="text-lg">{currentFlashcard.front}</h3>
                <div className="w-full h-px bg-border" />
                <p className="text-sm leading-relaxed">{currentFlashcard.back}</p>
              </div>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Navigation and Actions */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Navigation */}
        <Card>
          <CardContent className="p-4">
            <div className="flex justify-between items-center">
              <Button variant="outline" onClick={handlePrevious}>
                <ArrowLeft className="mr-2 h-4 w-4" />
                Previous
              </Button>
              <span className="text-sm text-muted-foreground">
                {currentCard + 1} / {displayCards.length}
              </span>
              <Button variant="outline" onClick={handleNext}>
                Next
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            </div>
          </CardContent>
        </Card>

        {/* Knowledge Assessment */}
        <Card>
          <CardContent className="p-4">
            <div className="flex space-x-2">
              <Button 
                variant="outline" 
                size="sm" 
                onClick={handleKnown}
                className="flex-1 text-green-600 border-green-200 hover:bg-green-50"
                disabled={!isFlipped}
              >
                <CheckCircle className="mr-2 h-4 w-4" />
                Know It
              </Button>
              <Button 
                variant="outline" 
                size="sm" 
                onClick={handleDifficult}
                className="flex-1 text-red-600 border-red-200 hover:bg-red-50"
                disabled={!isFlipped}
              >
                <XCircle className="mr-2 h-4 w-4" />
                Need Practice
              </Button>
            </div>
            {!isFlipped && (
              <p className="text-xs text-muted-foreground mt-2 text-center">
                Flip card to rate your knowledge
              </p>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Study Tips */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Study Tips</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
            <div>
              <h4 className="font-medium mb-2">Effective Studying:</h4>
              <ul className="space-y-1 text-muted-foreground">
                <li>• Try to answer before flipping</li>
                <li>• Mark cards honestly</li>
                <li>• Review difficult cards frequently</li>
              </ul>
            </div>
            <div>
              <h4 className="font-medium mb-2">Memory Techniques:</h4>
              <ul className="space-y-1 text-muted-foreground">
                <li>• Create mental associations</li>
                <li>• Use the shuffle feature</li>
                <li>• Study in short sessions</li>
              </ul>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}