#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
  if [[ $WINNER != "winner" ]]
  then
  #insert WINNER into teams table 
  INSERT_INTO_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
  INSERT_INTO_TEAMS2=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

  #get WINNER_ID/OPPONENT_ID from teams table
  WINNER_IDD=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_IDD=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  
  #insert all values into games table
  INSERT_INTO_GAMES=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_IDD,$OPPONENT_IDD,$WINNER_GOALS,$OPPONENT_GOALS)")
     fi
done