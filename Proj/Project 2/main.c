#include<stdio.h>
#include<time.h>

#define MAP_WIDTH 25
#define MAP_SIZE 625

char map [MAP_SIZE];
int score = 0;

struct Coord {
	int x;
	int y;
};

struct Stats {
	int hp;
	int attack;
	int defense;
	float speed;
};

struct Battler {
	struct Stats stats;
	struct Coord pos;
	const char* name;
};

void attack (struct Battler* attacker,struct Battler* receiver) {
	if (attacker->stats.attack > receiver->stats.defense) {
		receiver->stats.hp-=attacker->stats.attack-receiver->stats.defense;
	} else {
		receiver->stats.hp-=1;
	}
}
void battle (struct Battler* player,struct Battler* enemy) {
	char choice;
	int run;
	int odds;
	printf("%s encountered!\n",enemy->name);
	while (1) {
		if (player->stats.hp <= 0) {
			score+=1;
			return;
		} else if (enemy->stats.hp <= 0) {
			score+=1;
			return;
		}
		printf("HP: %d     Enemy HP: %d\n",player->stats.hp,enemy->stats.hp);
		printf("-------------------------\n");
		printf("|  a)Attack    b)Run    |\n");
		printf("-------------------------\n");
		printf("Which option do you choose?\n");
		scanf("%c",&choice);
		getchar();
		switch(choice) {
			case 'a':
			case 'A':
				attack(player,enemy);
				attack(enemy,player);
				break;
			case 'b':
			case 'B':
				if (player->stats.speed > enemy->stats.speed) {
					printf("You ran away!\n");
					run = 1;
					score+=1;
				} else {
					odds = rand() % 100;
					if (odds < 20) {
						printf("You ran away!\n");
						run = 1;
						score+=1;
					} else {
						printf("You couldn't escape!\n");
						attack(enemy,player);
					}
				}
				break;
		}
		if (run == 1) {
			break;
		}
	}
}

void initBattle (struct Battler* player, int hp, int attack, 
		int defense, float speed, const char* name) {
	struct Battler enemy;
	enemy.stats.hp = hp;
	enemy.stats.attack = attack;
	enemy.stats.defense = defense;
	enemy.stats.speed = speed;
	enemy.name = name;
	battle(player,&enemy);
}

void chanceEncounter (struct Battler* player) {
	int odds = rand() % 100;
	if (odds < 15) {
		odds = rand() % 6;
		switch(odds) {
			case 0:
				initBattle(player,50,11,2,5.0f,"Enemy V1");
				break;
			case 1:
				initBattle(player,55,12,2,5.1f,"Enemy V2");
				break;
			case 2:
				initBattle(player,60,13,3,5.2f,"Enemy V3");
				break;
			case 3:
				initBattle(player,67,15,5,6.0f,"Enemy V4");
				break;
			case 4:
				initBattle(player,78,17,2,7.0f,"Enemy V5");
				break;
			case 5:
				initBattle(player,210,35,10,8.0f,"Enemy V6");
				break;
		}
	}
}

int main() {
	struct Battler player;
	char choice;
	int i;
	srand(time(NULL));
	for (i=0;i<MAP_SIZE;++i) {
		map[i] = '^';
	}
	player.stats.hp = 100;
	player.stats.attack = 51;
	player.stats.defense = 5;
	player.stats.speed = 6.0f;
	player.pos.x = 12;
	player.pos.y = 12;
	map[player.pos.x+MAP_WIDTH*player.pos.y]='Y';
	player.name = "Hero";
	while (1) {
		if (player.stats.hp <= 0) {
			printf("You have died!\n    GAME OVER!\n\n");
			printf("You entered %d battles.\n",score);
			return;
		}
		printf("Position: (%d,%d)\n",player.pos.x,player.pos.y);
		printf("HP: %d\n",player.stats.hp);
		for (i=0;i<MAP_SIZE;++i) {
			if (i%MAP_WIDTH == 0) {
				printf("\n");
			}
			printf("%c",map[i]);
		}
		printf("\n\nPress r for Right, l for Left, u for Up, or d for down.\n");
		printf("or... Press q to quit\n");
		scanf("%c",&choice);
		getchar();
		switch(choice) {
		       	case 'r':
		       	case 'R':
				player.pos.x+=1;
				if (player.pos.x >= MAP_WIDTH) {
					player.pos.x=MAP_WIDTH-1;
					break;
				}
				map[player.pos.x-1+MAP_WIDTH*player.pos.y]='^';
				map[player.pos.x+MAP_WIDTH*player.pos.y]='Y';
				chanceEncounter(&player);
				break;
			case 'l':
			case 'L':
				player.pos.x-=1;
				if (player.pos.x < 0) {
					player.pos.x=0;
					break;
				}
				map[player.pos.x+1+MAP_WIDTH*player.pos.y]='^';
				map[player.pos.x+MAP_WIDTH*player.pos.y]='Y';
				chanceEncounter(&player);
				break;
			case 'u':
			case 'U':
				player.pos.y-=1;
				if (player.pos.y < 0) {
					player.pos.y=0;
					break;
				}
				map[player.pos.x+MAP_WIDTH*(player.pos.y+1)]='^';
				map[player.pos.x+MAP_WIDTH*player.pos.y]='Y';
				chanceEncounter(&player);
				break;
		       	case 'd':
		       	case 'D':
				player.pos.y+=1;
				if (player.pos.y >= MAP_WIDTH) {
					player.pos.y=MAP_WIDTH-1;
					break;
				}
				map[player.pos.x+MAP_WIDTH*(player.pos.y-1)]='^';
				map[player.pos.x+MAP_WIDTH*player.pos.y]='Y';
				chanceEncounter(&player);
				break;
		       	case 'q':
		       	case 'Q':
				printf("You entered %d battles.\n",score);
			       	return 0;
		}
	}
}
