import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { Badge } from "./ui/badge";
import { Progress } from "./ui/progress";
import { RadioGroup, RadioGroupItem } from "./ui/radio-group";
import { Label } from "./ui/label";
import { 
  CheckCircle, 
  XCircle, 
  RotateCcw, 
  Trophy, 
  Clock, 
  Target,
  ArrowRight,
  ArrowLeft
} from "lucide-react";

interface Question {
  id: number;
  question: string;
  options: string[];
  correctAnswer: number;
  explanation: string;
  topic: string;
}

interface QuizProps {
  onNavigate: (section: string) => void;
  quizType?: string;
}

export function Quiz({ onNavigate }: QuizProps) {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string>("");
  const [showResult, setShowResult] = useState(false);
  const [answers, setAnswers] = useState<number[]>([]);
  const [quizComplete, setQuizComplete] = useState(false);

  const questions: Question[] = [
    {
      id: 1,
      question: "Which planet is known as the 'Red Planet'?",
      options: ["Venus", "Mars", "Jupiter", "Saturn"],
      correctAnswer: 1,
      explanation: "Mars is called the 'Red Planet' because of iron oxide (rust) on its surface, which gives it a reddish appearance.",
      topic: "Solar System"
    },
    {
      id: 2,
      question: "What is the closest star to Earth?",
      options: ["Alpha Centauri", "Sirius", "The Sun", "Proxima Centauri"],
      correctAnswer: 2,
      explanation: "The Sun is the closest star to Earth at approximately 93 million miles (150 million kilometers) away.",
      topic: "Stars"
    },
    {
      id: 3,
      question: "Which type of galaxy is the Milky Way?",
      options: ["Elliptical", "Spiral", "Irregular", "Lenticular"],
      correctAnswer: 1,
      explanation: "The Milky Way is a barred spiral galaxy with distinctive spiral arms extending from a central bar structure.",
      topic: "Galaxies"
    },
    {
      id: 4,
      question: "What is the approximate age of the universe?",
      options: ["4.6 billion years", "13.8 billion years", "1 billion years", "25 billion years"],
      correctAnswer: 1,
      explanation: "The universe is approximately 13.8 billion years old, determined through cosmic microwave background radiation studies.",
      topic: "Cosmology"
    },
    {
      id: 5,
      question: "Which moon is the largest in our solar system?",
      options: ["Europa", "Titan", "Ganymede", "Callisto"],
      correctAnswer: 2,
      explanation: "Ganymede, one of Jupiter's moons, is the largest moon in our solar system and is even larger than the planet Mercury.",
      topic: "Solar System"
    }
  ];

  const handleAnswerSelect = (value: string) => {
    setSelectedAnswer(value);
  };

  const handleSubmitAnswer = () => {
    const answerIndex = parseInt(selectedAnswer);
    const newAnswers = [...answers];
    newAnswers[currentQuestion] = answerIndex;
    setAnswers(newAnswers);
    setShowResult(true);
  };

  const handleNextQuestion = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(currentQuestion + 1);
      setSelectedAnswer("");
      setShowResult(false);
    } else {
      setQuizComplete(true);
    }
  };

  const handlePrevQuestion = () => {
    if (currentQuestion > 0) {
      setCurrentQuestion(currentQuestion - 1);
      setSelectedAnswer(answers[currentQuestion - 1]?.toString() || "");
      setShowResult(false);
    }
  };

  const resetQuiz = () => {
    setCurrentQuestion(0);
    setSelectedAnswer("");
    setShowResult(false);
    setAnswers([]);
    setQuizComplete(false);
  };

  const calculateScore = () => {
    return answers.reduce((score, answer, index) => {
      return score + (answer === questions[index].correctAnswer ? 1 : 0);
    }, 0);
  };

  const getScorePercentage = () => {
    return Math.round((calculateScore() / questions.length) * 100);
  };

  const currentQ = questions[currentQuestion];
  const isCorrect = showResult && parseInt(selectedAnswer) === currentQ.correctAnswer;

  if (quizComplete) {
    const score = calculateScore();
    const percentage = getScorePercentage();
    
    return (
      <div className="max-w-2xl mx-auto space-y-6">
        <Card>
          <CardHeader className="text-center">
            <div className="mx-auto w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mb-4">
              <Trophy className="h-8 w-8 text-primary" />
            </div>
            <CardTitle>Quiz Complete!</CardTitle>
            <CardDescription>
              You've finished the astronomy quiz. Here are your results.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-primary">{percentage}%</div>
              <p className="text-muted-foreground">
                You scored {score} out of {questions.length} questions correctly
              </p>
            </div>

            <div className="space-y-4">
              <div className="flex justify-between text-sm">
                <span>Overall Performance</span>
                <span className="text-muted-foreground">{percentage}%</span>
              </div>
              <Progress value={percentage} className="h-3" />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
              <div className="space-y-1">
                <p className="text-2xl font-bold text-green-600">{score}</p>
                <p className="text-sm text-muted-foreground">Correct</p>
              </div>
              <div className="space-y-1">
                <p className="text-2xl font-bold text-red-600">{questions.length - score}</p>
                <p className="text-sm text-muted-foreground">Incorrect</p>
              </div>
              <div className="space-y-1">
                <p className="text-2xl font-bold text-blue-600">{questions.length}</p>
                <p className="text-sm text-muted-foreground">Total</p>
              </div>
            </div>

            <div className="space-y-2">
              <h3 className="font-medium">Performance by Topic</h3>
              {Array.from(new Set(questions.map(q => q.topic))).map(topic => {
                const topicQuestions = questions.filter(q => q.topic === topic);
                const topicCorrect = topicQuestions.reduce((acc, q, idx) => {
                  const globalIdx = questions.indexOf(q);
                  return acc + (answers[globalIdx] === q.correctAnswer ? 1 : 0);
                }, 0);
                const topicPercentage = Math.round((topicCorrect / topicQuestions.length) * 100);
                
                return (
                  <div key={topic} className="flex justify-between items-center">
                    <span className="text-sm">{topic}</span>
                    <Badge variant={topicPercentage >= 70 ? "default" : "secondary"}>
                      {topicCorrect}/{topicQuestions.length}
                    </Badge>
                  </div>
                );
              })}
            </div>

            <div className="flex space-x-3">
              <Button onClick={resetQuiz} variant="outline" className="flex-1">
                <RotateCcw className="mr-2 h-4 w-4" />
                Retake Quiz
              </Button>
              <Button onClick={() => onNavigate('study')} className="flex-1">
                Continue Learning
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      {/* Progress Header */}
      <Card>
        <CardContent className="p-4">
          <div className="flex items-center justify-between mb-2">
            <Badge variant="outline">{currentQ.topic}</Badge>
            <div className="flex items-center space-x-2 text-sm text-muted-foreground">
              <Clock className="h-4 w-4" />
              <span>Question {currentQuestion + 1} of {questions.length}</span>
            </div>
          </div>
          <Progress value={(currentQuestion / questions.length) * 100} className="h-2" />
        </CardContent>
      </Card>

      {/* Question Card */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-start space-x-3">
            <Target className="h-5 w-5 mt-1 flex-shrink-0" />
            <span>{currentQ.question}</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          <RadioGroup value={selectedAnswer} onValueChange={handleAnswerSelect}>
            <div className="space-y-3">
              {currentQ.options.map((option, index) => (
                <div key={index} className="flex items-center space-x-2">
                  <RadioGroupItem 
                    value={index.toString()} 
                    id={`option-${index}`}
                    disabled={showResult}
                  />
                  <Label 
                    htmlFor={`option-${index}`} 
                    className={`flex-1 cursor-pointer p-3 rounded-lg border transition-colors ${
                      showResult 
                        ? index === currentQ.correctAnswer
                          ? 'bg-green-50 border-green-200 text-green-800 dark:bg-green-900/20 dark:border-green-800 dark:text-green-300'
                          : selectedAnswer === index.toString() && index !== currentQ.correctAnswer
                          ? 'bg-red-50 border-red-200 text-red-800 dark:bg-red-900/20 dark:border-red-800 dark:text-red-300'
                          : 'bg-muted'
                        : 'hover:bg-muted'
                    }`}
                  >
                    <div className="flex items-center space-x-2">
                      <span>{option}</span>
                      {showResult && index === currentQ.correctAnswer && (
                        <CheckCircle className="h-4 w-4 text-green-600" />
                      )}
                      {showResult && selectedAnswer === index.toString() && index !== currentQ.correctAnswer && (
                        <XCircle className="h-4 w-4 text-red-600" />
                      )}
                    </div>
                  </Label>
                </div>
              ))}
            </div>
          </RadioGroup>

          {showResult && (
            <div className={`p-4 rounded-lg ${
              isCorrect 
                ? 'bg-green-50 border border-green-200 dark:bg-green-900/20 dark:border-green-800' 
                : 'bg-red-50 border border-red-200 dark:bg-red-900/20 dark:border-red-800'
            }`}>
              <div className="flex items-start space-x-2">
                {isCorrect ? (
                  <CheckCircle className="h-5 w-5 text-green-600 mt-0.5" />
                ) : (
                  <XCircle className="h-5 w-5 text-red-600 mt-0.5" />
                )}
                <div>
                  <p className={`font-medium ${
                    isCorrect ? 'text-green-800 dark:text-green-300' : 'text-red-800 dark:text-red-300'
                  }`}>
                    {isCorrect ? 'Correct!' : 'Incorrect'}
                  </p>
                  <p className={`text-sm mt-1 ${
                    isCorrect ? 'text-green-700 dark:text-green-400' : 'text-red-700 dark:text-red-400'
                  }`}>
                    {currentQ.explanation}
                  </p>
                </div>
              </div>
            </div>
          )}

          <div className="flex justify-between">
            <Button 
              onClick={handlePrevQuestion} 
              variant="outline"
              disabled={currentQuestion === 0}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Previous
            </Button>
            
            {!showResult ? (
              <Button 
                onClick={handleSubmitAnswer} 
                disabled={!selectedAnswer}
              >
                Submit Answer
              </Button>
            ) : (
              <Button onClick={handleNextQuestion}>
                {currentQuestion === questions.length - 1 ? 'Finish Quiz' : 'Next Question'}
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}