extends Node
# MoneyEngine: Maintains player's money earnings, compares earnings to required quota


enum EarnType {
	HURT_ADVENTURER,
	KILL_ADVENTURER,
	TOTAL_PARTY_KILL,
	TREASURE_REACHED,
	# additional EarnTypes if time:
	# TOTAL_ROOMS_TRAVERSED ($$)
	# TOTAL_ADVENTURERS ($$)
}

@export var quota: int = 2000	# TODO: balance quota and earnings
static var money: int = 0
var earnings_by_type = {
	EarnType.TREASURE_REACHED: -999,
	EarnType.HURT_ADVENTURER: 50,
	EarnType.KILL_ADVENTURER: 250,
	EarnType.TOTAL_PARTY_KILL: 1000,
}


func earn_money(type: EarnType) -> void:
	money += earnings_by_type[type]
	# can use clampi if want to limit money, e.g. between 0 and 9999999999999
	# it is funny though if player can go into the negative


func has_met_quota() -> bool:
	# Determines if win condition (quota) has been met
	return money >= quota
