using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//When attached to GameObjects, it'll put on a RB2D
[RequireComponent(typeof(Rigidbody2D))]

public class Arrow : MonoBehaviour {

	[SerializeField]
	private float speed;
	private Rigidbody2D myRB;
	float delay = 8f;

	public Collider2D cols;

	//private Vector2 direction;



	// Use this for initialization
	void Start () {
		myRB = GetComponent<Rigidbody2D> ();
		cols = GetComponent < BoxCollider2D> ();
		//direction = Vector2.left;
		//float 
		//myRB.AddForce(this.direction);
		//timeDestroy();
	}

	void FixedUpdate() {
		//myRB.velocity = direction*speed;
	}
	
	// Update is called once per frame
	void Update () {
		Destroy (gameObject, delay);
	}
		
		
	public void Initialize(Vector2 direction) {
		//this.direction = direction;
		//myRB.AddForce (direction*speed);
		//myRB.velocity = direction*speed;
	}

	/*
	//Remove projectile when out of view
	void OnBecameInvisible() {
		Destroy (gameObject);
	}
	*/


	void OnCollisionEnter2D (Collision2D hitter) {
		//Destroy (myRB);
		/////GetComponent<Rigidbody2D>().constraints = Rigidbody2DConstraints.FreezePositionX | RigidbodyConstraints.FreezePositionY;
		//Destroy (GetComponent<BoxCollider2D> ());
		myRB.isKinematic = true;//Stop physics
		myRB.Sleep();
		cols.enabled = false;
		transform.parent = hitter.transform;
		//Destroy (gameObject.rigidbody2D);
	}

}
