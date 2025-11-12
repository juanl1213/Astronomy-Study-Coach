import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { Badge } from "../ui/badge";
import { ArrowLeft, TrendingUp, TrendingDown, Minus } from "lucide-react";

interface QuizHistoryProps {
  onNavigate: (section: string) => void;
}

export function QuizHistory({ onNavigate }: QuizHistoryProps) {
  const quizHistory = [
    {
      id: 1,
      quiz: 'General Astronomy',
      score: 85,
      totalQuestions: 20,
      date: '2025-10-01',
      time: '18 min',
      trend: 'up'
    },
    {
      id: 2,
      quiz: 'Stars & Stellar Evolution',
      score: 75,
      totalQuestions: 12,
      date: '2025-09-28',
      time: '14 min',
      trend: 'same'
    },
    {
      id: 3,
      quiz: 'Galaxies Quiz',
      score: 90,
      totalQuestions: 10,
      date: '2025-09-25',
      time: '11 min',
      trend: 'up'
    },
    {
      id: 4,
      quiz: 'Planets Quiz',
      score: 80,
      totalQuestions: 15,
      date: '2025-09-22',
      time: '13 min',
      trend: 'down'
    },
    {
      id: 5,
      quiz: 'Solar System Quiz',
      score: 95,
      totalQuestions: 10,
      date: '2025-09-20',
      time: '9 min',
      trend: 'up'
    },
    {
      id: 6,
      quiz: 'General Astronomy',
      score: 70,
      totalQuestions: 20,
      date: '2025-09-18',
      time: '22 min',
      trend: 'down'
    },
    {
      id: 7,
      quiz: 'Stars & Stellar Evolution',
      score: 75,
      totalQuestions: 12,
      date: '2025-09-15',
      time: '15 min',
      trend: 'up'
    },
    {
      id: 8,
      quiz: 'Planets Quiz',
      score: 88,
      totalQuestions: 15,
      date: '2025-09-12',
      time: '12 min',
      trend: 'up'
    }
  ];

  const getScoreColor = (score: number) => {
    if (score >= 90) return 'text-green-600 dark:text-green-400';
    if (score >= 70) return 'text-yellow-600 dark:text-yellow-400';
    return 'text-red-600 dark:text-red-400';
  };

  const getScoreBadgeVariant = (score: number) => {
    if (score >= 90) return 'default';
    if (score >= 70) return 'secondary';
    return 'destructive';
  };

  const getTrendIcon = (trend: string) => {
    switch (trend) {
      case 'up':
        return <TrendingUp className="h-4 w-4 text-green-600 dark:text-green-400" />;
      case 'down':
        return <TrendingDown className="h-4 w-4 text-red-600 dark:text-red-400" />;
      default:
        return <Minus className="h-4 w-4 text-muted-foreground" />;
    }
  };

  const calculateStats = () => {
    const total = quizHistory.length;
    const avgScore = Math.round(
      quizHistory.reduce((sum, quiz) => sum + quiz.score, 0) / total
    );
    const bestScore = Math.max(...quizHistory.map(q => q.score));
    
    return { total, avgScore, bestScore };
  };

  const stats = calculateStats();

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1>Quiz History</h1>
          <p className="text-muted-foreground mt-2">
            Track your performance and improvement over time.
          </p>
        </div>
        <Button variant="ghost" onClick={() => onNavigate('quiz')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Quizzes
        </Button>
      </div>

      <div className="grid md:grid-cols-3 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <div className="text-muted-foreground mb-1">Total Quizzes</div>
              <div>{stats.total}</div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <div className="text-muted-foreground mb-1">Average Score</div>
              <div className={getScoreColor(stats.avgScore)}>{stats.avgScore}%</div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <div className="text-muted-foreground mb-1">Best Score</div>
              <div className={getScoreColor(stats.bestScore)}>{stats.bestScore}%</div>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Recent Attempts</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {quizHistory.map((attempt) => (
              <div
                key={attempt.id}
                className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="flex-1">
                  <div className="flex items-center space-x-3">
                    <div>
                      <h4>{attempt.quiz}</h4>
                      <div className="flex items-center space-x-3 text-sm text-muted-foreground mt-1">
                        <span>{attempt.date}</span>
                        <span>•</span>
                        <span>{attempt.time}</span>
                        <span>•</span>
                        <span>{attempt.totalQuestions} questions</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="flex items-center space-x-4">
                  {getTrendIcon(attempt.trend)}
                  <Badge variant={getScoreBadgeVariant(attempt.score) as any}>
                    {attempt.score}% ({Math.round(attempt.totalQuestions * attempt.score / 100)}/{attempt.totalQuestions})
                  </Badge>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Performance by Topic</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {[
              { topic: 'Solar System', attempts: 3, avgScore: 92 },
              { topic: 'Planets', attempts: 4, avgScore: 84 },
              { topic: 'Stars', attempts: 5, avgScore: 75 },
              { topic: 'Galaxies', attempts: 2, avgScore: 90 },
              { topic: 'General Astronomy', attempts: 3, avgScore: 75 }
            ].map((topic) => (
              <div key={topic.topic} className="space-y-2">
                <div className="flex items-center justify-between">
                  <span>{topic.topic}</span>
                  <div className="flex items-center space-x-3">
                    <span className="text-sm text-muted-foreground">
                      {topic.attempts} attempts
                    </span>
                    <span className={getScoreColor(topic.avgScore)}>
                      {topic.avgScore}%
                    </span>
                  </div>
                </div>
                <div className="h-2 bg-muted rounded-full overflow-hidden">
                  <div
                    className="h-full bg-primary"
                    style={{ width: `${topic.avgScore}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
