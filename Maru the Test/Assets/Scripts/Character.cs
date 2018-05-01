using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Character : MonoBehaviour {
	//behaviours
	public float maxSpeed = 10f;
	protected bool facingRight = false;
	protected bool attacking = false;
	float projForce = 950f;

	//protected Animator anim;
	public Animator Anim { get; set; }


	[SerializeField]
	protected GameObject arrowPrefab;
	[SerializeField]
	protected Transform bowPos;



	//public abstract void handleAttack();



	// Use this for initialization
	public virtual void Start () {
		Anim = GetComponent<Animator>();

	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void Flip() {
		facingRight = !facingRight;
		Vector3 theScale = transform.localScale;
		theScale.x *= -1;
		transform.localScale = theScale;
	}
	public void resetVars() {
		attacking = false;
	}

	//public virtual void
	public void ShootArrow(int value) {

		float variance = Random.Range (-6f, 6f);
		if (facingRight) {
			//throw Right
			Vector2 shooter = new Vector2 (1, variance/500);
			GameObject temp = (GameObject)Instantiate(arrowPrefab, bowPos.position, Quaternion.Euler(new Vector3(0,0,180)));
			temp.GetComponent<Arrow> ().Initialize (shooter);
			//temp.myRB.AddForce(

			temp.GetComponent<Rigidbody2D>().AddForce(shooter*projForce);
		} else {
			//throw Left
			GameObject temp = (GameObject)Instantiate(arrowPrefab, bowPos.position, Quaternion.identity);
			Vector2 shooter = new Vector2 (-1, variance/500);
			temp.GetComponent<Arrow> ().Initialize (shooter);
			temp.GetComponent<Rigidbody2D>().AddForce(shooter*projForce);
		}
	}
}
