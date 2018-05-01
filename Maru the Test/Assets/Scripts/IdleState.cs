﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IdleState : IEnemyState {
	private Enemy enemy;
	private float idleTimer;
	private float idleDuration = 5;

	public void Enter (Enemy enemy){
		this.enemy = enemy;
	}

	public void Execute() {
		//Debug.Log ("Idle");
		Idle ();
	}

	public void Exit() {
	}

	public void OnTriggerEnter(Collider2D other) {
	}

	private void Idle() {
		enemy.Anim.SetFloat ("Speed", 0);

		idleTimer += Time.deltaTime;

		if (idleTimer >= idleDuration) {
			enemy.ChangeState (new PatrolState ());
		}
	}
}