import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { Badge } from "../ui/badge";
import { Trophy, Clock, Target, History } from "lucide-react";

interface QuizHomeProps {
  onNavigate: (section: string) => void;
}

export function QuizHome({ onNavigate }: QuizHomeProps) {
  const quizzes = [
    {
      id: 'solar-system',
      title: 'Solar System Quiz',
      description: 'Test your knowledge of our cosmic neighborhood',
      questions: 10,
      difficulty: 'Beginner',
      timeEstimate: '10 min',
      category: 'Solar System'
    },
    {
      id: 'planets',
      title: 'Planets Quiz',
      description: 'How well do you know the eight planets?',
      questions: 15,
      difficulty: 'Beginner',
      timeEstimate: '12 min',
      category: 'Planets'
    },
    {
      id: 'stars',
      title: 'Stars & Stellar Evolution',
      description: 'From protostars to black holes',
      questions: 12,
      difficulty: 'Intermediate',
      timeEstimate: '15 min',
      category: 'Stars'
    },
    {
      id: 'galaxies',
      title: 'Galaxies Quiz',
      description: 'Explore galactic structures and types',
      questions: 10,
      difficulty: 'Intermediate',
      timeEstimate: '12 min',
      category: 'Galaxies'
    },
    {
      id: 'general',
      title: 'General Astronomy',
      description: 'Mixed topics covering all astronomy',
      questions: 20,
      difficulty: 'Advanced',
      timeEstimate: '20 min',
      category: 'Mixed'
    }
  ];

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'Beginner':
        return 'bg-emerald-500/15 text-emerald-400 border border-emerald-500/30';
      case 'Intermediate':
        return 'bg-amber-500/15 text-amber-400 border border-amber-500/30';
      case 'Advanced':
        return 'bg-rose-500/15 text-rose-400 border border-rose-500/30';
      default:
        return '';
    }
  };

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      <div>
        <h1>Astronomy Quizzes</h1>
        <p className="text-muted-foreground mt-2">
          Challenge yourself and track your progress across different astronomy topics.
        </p>
      </div>

      <div className="grid md:grid-cols-3 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-primary/10 rounded-lg">
                <Trophy className="h-6 w-6 text-primary" />
              </div>
              <div>
                <div className="text-muted-foreground">Best Score</div>
                <div>85%</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-accent/10 rounded-lg">
                <Target className="h-6 w-6 text-accent" />
              </div>
              <div>
                <div className="text-muted-foreground">Quizzes Taken</div>
                <div>12</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-primary/10 rounded-lg">
                <Clock className="h-6 w-6 text-primary" />
              </div>
              <div>
                <div className="text-muted-foreground">Avg. Time</div>
                <div>14 min</div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        {quizzes.map((quiz) => (
          <Card key={quiz.id} className="hover:border-primary/50 transition-colors">
            <CardHeader>
              <div className="flex items-start justify-between">
                <div className="space-y-1">
                  <CardTitle>{quiz.title}</CardTitle>
                  <p className="text-muted-foreground">{quiz.description}</p>
                </div>
                <Badge className={getDifficultyColor(quiz.difficulty)}>
                  {quiz.difficulty}
                </Badge>
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-3 gap-4 text-sm">
                <div>
                  <div className="text-muted-foreground">Questions</div>
                  <div>{quiz.questions}</div>
                </div>
                <div>
                  <div className="text-muted-foreground">Time</div>
                  <div>{quiz.timeEstimate}</div>
                </div>
                <div>
                  <div className="text-muted-foreground">Category</div>
                  <div>{quiz.category}</div>
                </div>
              </div>
              <Button 
                className="w-full" 
                onClick={() => onNavigate(`quiz-${quiz.id}`)}
              >
                Start Quiz
              </Button>
            </CardContent>
          </Card>
        ))}
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <History className="h-5 w-5" />
            <span>Quick Access</span>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <Button 
              variant="outline" 
              className="w-full justify-start"
              onClick={() => onNavigate('quiz-history')}
            >
              <History className="mr-2 h-4 w-4" />
              View Quiz History
            </Button>
            <Button 
              variant="outline" 
              className="w-full justify-start"
              onClick={() => onNavigate('progress')}
            >
              <Trophy className="mr-2 h-4 w-4" />
              View Achievements
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
