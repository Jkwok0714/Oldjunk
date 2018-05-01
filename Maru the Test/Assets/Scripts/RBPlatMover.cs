using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RBPlatMover : MonoBehaviour {
	private Rigidbody2D rb2d;

	[SerializeField]
	private float speed;
	private float direction;

	[SerializeField]
	private float targetX;

	private float originX;

	// Use this for initialization
	void Awake ()  {
		rb2d = GetComponent<Rigidbody2D>();
		direction = 1;
		originX = rb2d.position.x;
	}
	
	// Update is called once per frame
	void Update () {
		moveIt();

	}

	private void moveIt() {
		rb2d.velocity = new Vector2(direction * speed, 0);

		if (rb2d.position.x < originX)
			direction = 1;
		else if (rb2d.position.x > targetX)
			direction = -1;
	}
}
