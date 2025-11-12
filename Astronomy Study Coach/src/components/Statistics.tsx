import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { ArrowLeft, TrendingUp, Clock, Target, Zap, Book, Brain } from "lucide-react";
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

interface StatisticsProps {
  onNavigate: (section: string) => void;
}

export function Statistics({ onNavigate }: StatisticsProps) {
  const weeklyData = [
    { day: 'Mon', minutes: 45, quizzes: 2 },
    { day: 'Tue', minutes: 30, quizzes: 1 },
    { day: 'Wed', minutes: 60, quizzes: 3 },
    { day: 'Thu', minutes: 25, quizzes: 1 },
    { day: 'Fri', minutes: 50, quizzes: 2 },
    { day: 'Sat', minutes: 70, quizzes: 4 },
    { day: 'Sun', minutes: 40, quizzes: 2 }
  ];

  const quizPerformance = [
    { month: 'Jun', score: 65 },
    { month: 'Jul', score: 72 },
    { month: 'Aug', score: 78 },
    { month: 'Sep', score: 85 }
  ];

  const topicMastery = [
    { topic: 'Solar System', mastery: 92 },
    { topic: 'Planets', mastery: 88 },
    { topic: 'Stars', mastery: 75 },
    { topic: 'Galaxies', mastery: 82 },
    { topic: 'Cosmology', mastery: 68 },
    { topic: 'Exoplanets', mastery: 71 }
  ];

  return (
    <div className="max-w-6xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1>Learning Statistics</h1>
          <p className="text-muted-foreground mt-2">
            Detailed insights into your study habits and progress.
          </p>
        </div>
        <Button variant="ghost" onClick={() => onNavigate('progress')}>
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Progress
        </Button>
      </div>

      <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-blue-500/10 rounded-lg">
                <Clock className="h-6 w-6 text-blue-600 dark:text-blue-400" />
              </div>
              <div>
                <div className="text-muted-foreground">Total Study Time</div>
                <div>18.5 hrs</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-green-500/10 rounded-lg">
                <Target className="h-6 w-6 text-green-600 dark:text-green-400" />
              </div>
              <div>
                <div className="text-muted-foreground">Avg. Quiz Score</div>
                <div>82%</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-purple-500/10 rounded-lg">
                <Zap className="h-6 w-6 text-purple-600 dark:text-purple-400" />
              </div>
              <div>
                <div className="text-muted-foreground">Current Streak</div>
                <div>7 days</div>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center space-x-3">
              <div className="p-3 bg-yellow-500/10 rounded-lg">
                <Book className="h-6 w-6 text-yellow-600 dark:text-yellow-400" />
              </div>
              <div>
                <div className="text-muted-foreground">Lessons Completed</div>
                <div>6 / 9</div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Weekly Study Time</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="h-64">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={weeklyData}>
                  <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                  <XAxis dataKey="day" className="text-xs" />
                  <YAxis className="text-xs" />
                  <Tooltip 
                    contentStyle={{ 
                      backgroundColor: 'hsl(var(--card))', 
                      border: '1px solid hsl(var(--border))' 
                    }}
                  />
                  <Bar dataKey="minutes" fill="hsl(var(--primary))" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
            <div className="mt-4 text-center text-sm text-muted-foreground">
              Total this week: 5.3 hours
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Quiz Performance Trend</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="h-64">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={quizPerformance}>
                  <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                  <XAxis dataKey="month" className="text-xs" />
                  <YAxis domain={[0, 100]} className="text-xs" />
                  <Tooltip 
                    contentStyle={{ 
                      backgroundColor: 'hsl(var(--card))', 
                      border: '1px solid hsl(var(--border))' 
                    }}
                  />
                  <Line 
                    type="monotone" 
                    dataKey="score" 
                    stroke="hsl(var(--primary))" 
                    strokeWidth={2}
                    dot={{ fill: 'hsl(var(--primary))', r: 4 }}
                  />
                </LineChart>
              </ResponsiveContainer>
            </div>
            <div className="mt-4 flex items-center justify-center space-x-2 text-sm">
              <TrendingUp className="h-4 w-4 text-green-600 dark:text-green-400" />
              <span className="text-green-600 dark:text-green-400">+20% improvement</span>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Topic Mastery</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {topicMastery.map((topic) => (
            <div key={topic.topic} className="space-y-2">
              <div className="flex items-center justify-between">
                <span>{topic.topic}</span>
                <span className="text-muted-foreground">{topic.mastery}%</span>
              </div>
              <div className="h-2 bg-muted rounded-full overflow-hidden">
                <div
                  className="h-full bg-primary transition-all"
                  style={{ width: `${topic.mastery}%` }}
                />
              </div>
            </div>
          ))}
        </CardContent>
      </Card>

      <div className="grid md:grid-cols-3 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Study Habits</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Avg. Session</span>
              <span>42 min</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Best Day</span>
              <span>Saturday</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Preferred Time</span>
              <span>Evening</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Longest Streak</span>
              <span>14 days</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Learning Activity</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Lessons Read</span>
              <span>6</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Quizzes Taken</span>
              <span>15</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Flashcards Reviewed</span>
              <span>87</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Notes Created</span>
              <span>12</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Performance</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Questions Answered</span>
              <span>245</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Correct Answers</span>
              <span>201</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Accuracy Rate</span>
              <span>82%</span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-muted-foreground">Perfect Quizzes</span>
              <span>3</span>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="flex items-center space-x-2">
            <Brain className="h-5 w-5" />
            <span>Learning Insights</span>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="p-4 bg-blue-500/10 border border-blue-500/20 rounded-lg">
            <strong className="text-blue-700 dark:text-blue-400">Strong Areas:</strong>
            <p className="text-muted-foreground mt-1">
              You're excelling in Solar System and Planets topics. Keep up the great work!
            </p>
          </div>
          <div className="p-4 bg-yellow-500/10 border border-yellow-500/20 rounded-lg">
            <strong className="text-yellow-700 dark:text-yellow-400">Improvement Opportunities:</strong>
            <p className="text-muted-foreground mt-1">
              Consider reviewing Cosmology and Exoplanets materials to boost your scores in these areas.
            </p>
          </div>
          <div className="p-4 bg-green-500/10 border border-green-500/20 rounded-lg">
            <strong className="text-green-700 dark:text-green-400">Study Tip:</strong>
            <p className="text-muted-foreground mt-1">
              You study most effectively on Saturday evenings. Try to schedule important review sessions during this time.
            </p>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
