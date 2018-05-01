using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : Character {

	private IEnemyState currState;

	// Use this for initialization
	public override void Start () {
		base.Start ();

		ChangeState (new IdleState ());
	}
	
	// Update is called once per frame
	void Update () {
		currState.Execute ();
	}

	public void ChangeState(IEnemyState newState) {
		if (currState != null) {
			currState.Exit ();
		}
		currState = newState;

		currState.Enter (this);
	}

	public void Move() {
		Anim.SetFloat ("Speed", 1);

		transform.Translate (GetDirection () * (maxSpeed * Time.deltaTime));
	}

	public Vector2 GetDirection() {
		return facingRight ? Vector2.right : Vector2.left;
	}
}
