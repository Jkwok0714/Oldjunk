﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PatrolState : IEnemyState {
	private Enemy enemy;
	private float patrolTimer;
	private float patrolDuration = 10;


	public void Enter (Enemy enemy){
		this.enemy = enemy;
	}

	public void Execute() {
		Patrol ();
		//Debug.Log ("Patrol");

		enemy.Move ();
	}

	public void Exit() {
	}

	public void OnTriggerEnter(Collider2D other) {
	}

	private void Patrol() {
		//enemy.Anim.SetFloat ("Speed", 0);

		patrolTimer += Time.deltaTime;

		if (patrolTimer >= patrolDuration) {
			enemy.ChangeState (new IdleState ());
		}
	}
}