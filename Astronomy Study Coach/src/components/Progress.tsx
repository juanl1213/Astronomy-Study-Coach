import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "./ui/card";
import { Progress as ProgressBar } from "./ui/progress";
import { Badge } from "./ui/badge";
import { Button } from "./ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "./ui/tabs";
import { 
  Trophy, 
  Target, 
  Clock, 
  Calendar, 
  TrendingUp, 
  Star,
  BookOpen,
  Award,
  Flame,
  CheckCircle,
  BarChart3,
  ArrowRight
} from "lucide-react";

interface ProgressProps {
  onNavigate: (section: string) => void;
}

export function Progress({ onNavigate }: ProgressProps) {
  const overallProgress = {
    totalTopics: 8,
    completedTopics: 3,
    totalLessons: 89,
    completedLessons: 42,
    totalQuizzes: 24,
    completedQuizzes: 18,
    studyTime: 1472, // minutes
    currentStreak: 7,
    longestStreak: 12
  };

  const topicProgress = [
    { name: 'Solar System', progress: 85, lessons: 12, completed: 10, quiz: 95 },
    { name: 'Telescopes & Observation', progress: 75, lessons: 10, completed: 8, quiz: 88 },
    { name: 'Space Exploration', progress: 90, lessons: 8, completed: 8, quiz: 92 },
    { name: 'Stars & Stellar Evolution', progress: 45, lessons: 15, completed: 7, quiz: 72 },
    { name: 'Galaxies & Nebulae', progress: 25, lessons: 18, completed: 4, quiz: 0 },
    { name: 'Cosmology & Big Bang', progress: 15, lessons: 20, completed: 3, quiz: 0 },
    { name: 'Exoplanets', progress: 10, lessons: 6, completed: 1, quiz: 0 },
    { name: 'Black Holes & Relativity', progress: 5, lessons: 12, completed: 1, quiz: 0 }
  ];

  const achievements = [
    {
      id: 1,
      title: 'Solar System Expert',
      description: 'Completed all solar system lessons',
      icon: Trophy,
      earned: true,
      date: '2025-01-15',
      rarity: 'Gold'
    },
    {
      id: 2,
      title: 'Quiz Master',
      description: 'Scored 90%+ on 5 consecutive quizzes',
      icon: Target,
      earned: true,
      date: '2025-01-20',
      rarity: 'Silver'
    },
    {
      id: 3,
      title: 'Dedicated Learner',
      description: 'Maintained a 7-day study streak',
      icon: Flame,
      earned: true,
      date: '2025-01-22',
      rarity: 'Bronze'
    },
    {
      id: 4,
      title: 'Star Gazer',
      description: 'Learned 10 constellation patterns',
      icon: Star,
      earned: true,
      date: '2025-01-18',
      rarity: 'Bronze'
    },
    {
      id: 5,
      title: 'Time Traveler',
      description: 'Study cosmology for 5 hours',
      icon: Clock,
      earned: false,
      date: null,
      rarity: 'Gold'
    },
    {
      id: 6,
      title: 'Stellar Scholar',
      description: 'Complete all stellar evolution lessons',
      icon: BookOpen,
      earned: false,
      date: null,
      rarity: 'Silver'
    }
  ];

  const studyStats = [
    {
      period: 'This Week',
      studyTime: 320,
      lessonsCompleted: 8,
      quizzesCompleted: 3,
      averageScore: 88
    },
    {
      period: 'This Month',
      studyTime: 1472,
      lessonsCompleted: 24,
      quizzesCompleted: 12,
      averageScore: 85
    },
    {
      period: 'All Time',
      studyTime: 2940,
      lessonsCompleted: 42,
      quizzesCompleted: 18,
      averageScore: 87
    }
  ];

  const formatTime = (minutes: number) => {
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    return `${hours}h ${mins}m`;
  };

  const getRarityColor = (rarity: string) => {
    switch (rarity) {
      case 'Gold': return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300';
      case 'Silver': return 'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-300';
      case 'Bronze': return 'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-300';
      default: return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300';
    }
  };

  return (
    <div className="space-y-6">
      <div className="text-center space-y-2">
        <h1>Learning Progress</h1>
        <p className="text-muted-foreground">
          Track your astronomy learning journey and celebrate your achievements
        </p>
      </div>

      {/* Overall Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center space-x-2">
              <BookOpen className="h-5 w-5 text-primary" />
              <div>
                <p className="text-sm text-muted-foreground">Topics Completed</p>
                <p className="font-medium">{overallProgress.completedTopics}/{overallProgress.totalTopics}</p>
              </div>
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center space-x-2">
              <Target className="h-5 w-5 text-primary" />
              <div>
                <p className="text-sm text-muted-foreground">Quizzes Passed</p>
                <p className="font-medium">{overallProgress.completedQuizzes}/{overallProgress.totalQuizzes}</p>
              </div>
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center space-x-2">
              <Clock className="h-5 w-5 text-primary" />
              <div>
                <p className="text-sm text-muted-foreground">Total Study Time</p>
                <p className="font-medium">{formatTime(overallProgress.studyTime)}</p>
              </div>
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center space-x-2">
              <Flame className="h-5 w-5 text-orange-500" />
              <div>
                <p className="text-sm text-muted-foreground">Current Streak</p>
                <p className="font-medium">{overallProgress.currentStreak} days</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="progress" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="progress">Topic Progress</TabsTrigger>
          <TabsTrigger value="achievements">Achievements</TabsTrigger>
          <TabsTrigger value="statistics">Statistics</TabsTrigger>
        </TabsList>
        
        <TabsContent value="progress" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center space-x-2">
                <TrendingUp className="h-5 w-5" />
                <span>Learning Progress by Topic</span>
              </CardTitle>
              <CardDescription>
                Your advancement through each astronomy topic
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {topicProgress.map((topic, index) => (
                  <div key={index} className="space-y-2">
                    <div className="flex justify-between items-center">
                      <span className="font-medium">{topic.name}</span>
                      <div className="flex items-center space-x-2">
                        <Badge variant="outline" className="text-xs">
                          {topic.completed}/{topic.lessons} lessons
                        </Badge>
                        {topic.quiz > 0 && (
                          <Badge variant="secondary" className="text-xs">
                            Quiz: {topic.quiz}%
                          </Badge>
                        )}
                      </div>
                    </div>
                    <div className="flex items-center space-x-2">
                      <ProgressBar value={topic.progress} className="flex-1 h-2" />
                      <span className="text-sm text-muted-foreground w-12">
                        {topic.progress}%
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
        
        <TabsContent value="achievements" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center space-x-2">
                <Trophy className="h-5 w-5" />
                <span>Achievements & Badges</span>
              </CardTitle>
              <CardDescription>
                Milestones you've reached in your astronomy studies
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {achievements.map((achievement) => (
                  <div 
                    key={achievement.id} 
                    className={`p-4 rounded-lg border ${
                      achievement.earned 
                        ? 'bg-card border-border' 
                        : 'bg-muted/50 border-dashed opacity-60'
                    }`}
                  >
                    <div className="flex items-start space-x-3">
                      <div className={`p-2 rounded-lg ${
                        achievement.earned 
                          ? 'bg-primary/10' 
                          : 'bg-muted'
                      }`}>
                        <achievement.icon className={`h-5 w-5 ${
                          achievement.earned ? 'text-primary' : 'text-muted-foreground'
                        }`} />
                      </div>
                      <div className="flex-1">
                        <div className="flex items-start justify-between">
                          <div>
                            <h4 className="font-medium">{achievement.title}</h4>
                            <p className="text-sm text-muted-foreground">
                              {achievement.description}
                            </p>
                          </div>
                          <Badge className={getRarityColor(achievement.rarity)} variant="secondary">
                            {achievement.rarity}
                          </Badge>
                        </div>
                        {achievement.earned && achievement.date && (
                          <div className="flex items-center space-x-1 mt-2">
                            <CheckCircle className="h-3 w-3 text-green-600" />
                            <span className="text-xs text-muted-foreground">
                              Earned on {new Date(achievement.date).toLocaleDateString()}
                            </span>
                          </div>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              
              <div className="mt-6 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
                <h4 className="font-medium mb-2">Achievement Progress</h4>
                <div className="flex justify-between text-sm">
                  <span>Achievements Earned</span>
                  <span>{achievements.filter(a => a.earned).length}/{achievements.length}</span>
                </div>
                <ProgressBar 
                  value={(achievements.filter(a => a.earned).length / achievements.length) * 100} 
                  className="mt-2 h-2" 
                />
                <Button 
                  className="w-full mt-4" 
                  variant="outline"
                  onClick={() => onNavigate('achievements')}
                >
                  View All Achievements
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
        
        <TabsContent value="statistics" className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {studyStats.map((stat, index) => (
              <Card key={index}>
                <CardHeader className="pb-3">
                  <CardTitle className="text-base">{stat.period}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span>Study Time</span>
                      <span className="font-medium">{formatTime(stat.studyTime)}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span>Lessons</span>
                      <span className="font-medium">{stat.lessonsCompleted}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span>Quizzes</span>
                      <span className="font-medium">{stat.quizzesCompleted}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span>Avg. Score</span>
                      <span className="font-medium">{stat.averageScore}%</span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
          
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center space-x-2">
                <Calendar className="h-5 w-5" />
                <span>Study Streak</span>
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="space-y-3">
                  <div className="text-center">
                    <div className="text-3xl font-bold text-primary">
                      {overallProgress.currentStreak}
                    </div>
                    <p className="text-sm text-muted-foreground">Current Streak</p>
                  </div>
                  <div className="text-center">
                    <div className="text-xl font-semibold text-muted-foreground">
                      {overallProgress.longestStreak}
                    </div>
                    <p className="text-sm text-muted-foreground">Longest Streak</p>
                  </div>
                </div>
                
                <div className="space-y-3">
                  <h4 className="font-medium">Keep Your Streak Going!</h4>
                  <ul className="text-sm space-y-1 text-muted-foreground">
                    <li>• Study for at least 15 minutes daily</li>
                    <li>• Complete one lesson or take a quiz</li>
                    <li>• Review flashcards during breaks</li>
                    <li>• Set reminders to maintain consistency</li>
                  </ul>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-3">
                  <BarChart3 className="h-8 w-8 text-primary" />
                  <div>
                    <h4>Detailed Statistics</h4>
                    <p className="text-sm text-muted-foreground">
                      View comprehensive learning analytics
                    </p>
                  </div>
                </div>
                <Button onClick={() => onNavigate('statistics')}>
                  View Stats
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}