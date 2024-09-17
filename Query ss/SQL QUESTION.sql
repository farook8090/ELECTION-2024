use election_24;

/*1. Total Seats -> 543*/

SELECT 
DISTINCT COUNT(
	Parliament_Constituency
) AS Total_Seats
FROM constituencywise_results;


/* Query - 2 
-> What are the total number of seats available for elections in each state I
*/

SELECT 
states.state as State_name,COUNT(
	DISTINCT constituencywise_results.Parliament_Constituency
) AS Total_seat
FROM constituencywise_results
INNER JOIN statewise_results 
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
INNER JOIN states 
ON statewise_results.STATE_ID = states.STATE_ID
GROUP BY states.state;


/* Query - 3 
-> Total Seats Won by NDA Alliance
*/

SELECT
SUM(
	CASE 
		WHEN party IN(
			'Bharatiya Janata Party - BJP', 
            'Telugu Desam - TDP', 
			'Janata Dal  (United) - JD(U)',
            'Shiv Sena - SHS', 
            'AJSU Party - AJSUP', 
            'Apna Dal (Soneylal) - ADAL', 
            'Asom Gana Parishad - AGP',
            'Hindustani Awam Morcha (Secular) - HAMS', 
            'Janasena Party - JnP', 
			'Janata Dal  (Secular) - JD(S)',
            'Lok Janshakti Party(Ram Vilas) - LJPRV', 
            'Nationalist Congress Party - NCP',
            'Rashtriya Lok Dal - RLD', 
            'Sikkim Krantikari Morcha - SKM'
		) THEN [won]
		ELSE 0 END
) AS NDA_Total_Seats_WON 
FROM partywise_results;

-- QUESTION - 4
-- Seats Won by NDA Allianz Parties

SELECT
	party AS Party_Name,
	won AS Seats_Won
FROM partywise_results
WHERE party IN(
	'Bharatiya Janata Party - BJP', 
    'Telugu Desam - TDP', 
	'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS', 
    'AJSU Party - AJSUP', 
    'Apna Dal (Soneylal) - ADAL', 
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS', 
    'Janasena Party - JnP', 
	'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV', 
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD', 
    'Sikkim Krantikari Morcha - SKM'
) ORDER BY Seats_Won DESC;

-- QUESTION - 5
-- Total Seats Won by I.N.D.I.A. Allianz
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results


-- QUESTION - 6
-- Seats Won by I.N.D.I.A. Allianz Parties

SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC;


-- QUESTION - 7
-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

--I.N.D.I.A

UPDATE partywise_results
SET party_alliance = 'I.N.I.D.A'
WHERE party IN(
	'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

--NDA
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN(
	'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

--OTHER
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

--SUM
SELECT
party_alliance,
SUM(WON)
FROM partywise_results
GROUP BY party_alliance;


--Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
SELECT 
    p.party_alliance,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    p.party_alliance
ORDER BY 
    Seats_Won DESC;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
SELECT
	constituencywise_results.Winning_Candidate,
	partywise_results.party,
	constituencywise_results.total_votes,
	constituencywise_results.margin,
	states.state,
	constituencywise_results.Constituency_Name
FROM
	constituencywise_results
	INNER JOIN partywise_results ON
	partywise_results.Party_ID=constituencywise_results.Party_ID
	INNER JOIN statewise_results ON statewise_results.Parliament_Constituency=constituencywise_results.Parliament_Constituency
	INNER JOIN states ON states.State_ID=statewise_results.State_ID
WHERE
	constituencywise_results.Constituency_Name='AGRA';

--What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
SELECT
	constituencywise_details.Candidate,
	constituencywise_details.Party,
	constituencywise_details.EVM_Votes,
	constituencywise_details.Postal_Votes,
	constituencywise_details.Total_Votes,
	constituencywise_results.Constituency_Name
FROM
	constituencywise_details INNER JOIN
	constituencywise_results ON constituencywise_results.Constituency_ID=constituencywise_details.Constituency_ID
WHERE
	constituencywise_results.Constituency_Name = 'MATHURA'
ORDER BY constituencywise_details.Total_Votes DESC;

--Which parties won the most seats in s State, and how many seats did each party win ?

SELECT
	partywise_results.Party,
	COUNT(constituencywise_results.Constituency_ID) AS TOTAL_SEATS_WON
FROM constituencywise_results
	JOIN partywise_results ON partywise_results.PARTY_ID=constituencywise_results.PARTY_ID
	JOIN statewise_results ON statewise_results.Parliament_Constituency=constituencywise_results.Parliament_Constituency
	JOIN states ON states.State_ID = statewise_results.State_ID
WHERE
	states.State = 'Andhra Pradesh'
GROUP BY partywise_results.Party
ORDER BY TOTAL_SEATS_WON DESC;


--What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT
	states.State,
	SUM(CASE WHEN partywise_results.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_SEAT_WON,
	SUM(CASE WHEN partywise_results.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_SEAT_WON,
	SUM(CASE WHEN partywise_results.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_SEAT_WON
FROM partywise_results
	JOIN constituencywise_results ON constituencywise_results.Party_ID = partywise_results.Party_ID
	JOIN statewise_results ON statewise_results.Parliament_Constituency = constituencywise_results.Parliament_Constituency
	JOIN states ON states.State_ID = statewise_results.State_ID
WHERE partywise_results.party_alliance IN('NDA','I.N.D.I.A','OTHER')
GROUP BY states.State
ORDER BY states.State;


--Which candidate received the highest number of EVM votes in each constituency (Top 10) ?

SELECT TOP 10
	constituencywise_results.Constituency_ID,
	constituencywise_results.Constituency_Name,
	constituencywise_details.Candidate,
	constituencywise_details.EVM_Votes
FROM constituencywise_details
	JOIN constituencywise_results ON constituencywise_results.Constituency_ID = constituencywise_details.Constituency_ID
ORDER BY constituencywise_details.EVM_Votes DESC;


--Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

WITH RankedCandidates AS(
	SELECT
		constituencywise_details.Constituency_ID,
		constituencywise_details.Candidate,
		constituencywise_details.EVM_Votes,
		constituencywise_details.Postal_Votes,
		constituencywise_results.Constituency_Name,
		constituencywise_details.EVM_Votes + constituencywise_details .Postal_Votes AS TOTAL_VOTES,
		ROW_NUMBER () OVER (
			PARTITION BY constituencywise_details.Constituency_ID ORDER BY constituencywise_details.EVM_Votes + constituencywise_details.Postal_Votes DESC
		) AS VoteRank
	FROM constituencywise_details
		JOIN constituencywise_results ON constituencywise_results.Constituency_ID = constituencywise_details.Constituency_ID
		JOIN statewise_results ON statewise_results.Parliament_Constituency=constituencywise_results.Parliament_Constituency
		JOIN states ON states.State_ID = statewise_results.State_ID
	WHERE
		states.State = 'MAHARASHTRA'
)
SELECT
	Constituency_Name,
	MAX(CASE WHEN VoteRank = 1 THEN Candidate END) AS WinningCandidate,
	MAX(CASE WHEN VoteRank = 2 THEN Candidate END) AS RunnerUpCandidate
FROM RankedCandidates
GROUP BY Constituency_Name
ORDER BY Constituency_Name;


--For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

SELECT

	COUNT(DISTINCT constituencywise_results.Constituency_ID) AS TOTAL_SEATS,
	COUNT(DISTINCT constituencywise_details.Candidate) AS TOTAL_CANDIDATES,
	COUNT(DISTINCT partywise_results.Party) AS TOTAL_PARTIES,
	SUM(constituencywise_details.EVM_Votes) AS TOTAL_EVM_VOTES,
	SUM(constituencywise_details.Postal_Votes) AS TOTAL_POSTAL_VOTES,
	SUM(constituencywise_details.EVM_Votes + constituencywise_details.Postal_Votes) AS TOTAL_VOTES

FROM constituencywise_results

	JOIN constituencywise_details ON constituencywise_details.Constituency_ID = constituencywise_results.Constituency_ID
	JOIN statewise_results ON statewise_results.Parliament_Constituency = constituencywise_results.Parliament_Constituency
	JOIN states ON states.State_ID=statewise_results.State_ID
	JOIN partywise_results ON partywise_results.Party_ID=constituencywise_results.Party_ID

WHERE states.State = 'Maharashtra';
