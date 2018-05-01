using UnityEngine;
using System.Collections;
//using System.Collections.Generic;

public class MaruController : Character {
	private static MaruController instance;

	public static MaruController Instance {
		get {
			if (instance == null) {
				instance = GameObject.FindObjectOfType<MaruController> ();
			}
			return instance;
		}
	}


	//bool jump = false;
	public float jumpForce = 1000f;
	//public Transform groundCheck;


	//private bool grounded = false;
	private Rigidbody2D rb2d;

	//For falling
	private bool grounded = false;
	public Transform groundCheck;
	float groundRadius = 0.2f;
	public LayerMask whatIsGround;

	//private float atkTimer = 0.3f;

	// Use this for initialization
	//void Start () {
		
	//}

	public override void Start ()  {
		//Use parent class's start function
		base.Start ();
		rb2d = GetComponent<Rigidbody2D>();
	}
	
	// Update is called once per frame
		/*
	void Update () {
		
	}
	*/

	void Update () {
		
		handleInput ();


		/*
		//Unattack
		if (attacking) {
			if (atkTimer > 0) {
				atkTimer -= Time.deltaTime;
			} else {
				//Anim.SetBool ("Attacking", false);
				attacking = false;
				atkTimer = 0.3f;
			}
		}
		*/
			
	}

	private void handleInput () {
		//Don't interrupt attack animations
		if (!this.Anim.GetCurrentAnimatorStateInfo(0).IsTag("Attack")) {
			//Yump
			if (grounded && Input.GetButtonDown ("Jump")) {
				Anim.SetBool ("Ground", false);
				rb2d.AddForce (new Vector2 (0, jumpForce));
			}
			//Attack 1
			if (Input.GetButtonDown ("Fire1")) {
				//anim.SetBool ("Attacking", true);
				//Attack();
				attacking = true;
			}
			//Attack 2 (Bow test)
			if (Input.GetButtonDown ("Fire2")) {
				//anim.SetBool ("Attacking", true);
				//Attack();
				if (grounded) {
					Anim.SetTrigger ("Bow");
					//ShootArrow (0);
				}
			}
		}
	}
		

	void handleAttack () {
		if (attacking && !this.Anim.GetCurrentAnimatorStateInfo(0).IsTag("Attack")) {
			if (grounded) {
				Anim.SetTrigger ("Attack");
			} else {
				Anim.SetTrigger ("Attack");
			}
			//Anim.SetBool ("Ground", true);
			//rb2d.velocity = Vector2.zero;
		}
	}

	void handleMoving() {
		if (!this.Anim.GetCurrentAnimatorStateInfo(0).IsTag("Attack")) {
			//Check if on the ground
			grounded = Physics2D.OverlapCircle (groundCheck.position, groundRadius, whatIsGround);
			Anim.SetBool ("Ground", grounded);

			//Anim.SetFloat ("vSpeed", rb2d.velocity.y);

			float move = Input.GetAxis ("Horizontal");


			Anim.SetFloat ("Speed", Mathf.Abs (move));
			rb2d.velocity = new Vector2 (move * maxSpeed, rb2d.velocity.y);


			if (move > 0 && !facingRight)
				Flip ();
			else if (move < 0 && facingRight)
				Flip ();
		}
	}

	void FixedUpdate() {

		handleMoving ();

		handleAttack ();

		resetVars ();

	}

	//private override void ShootArrow
		
}
