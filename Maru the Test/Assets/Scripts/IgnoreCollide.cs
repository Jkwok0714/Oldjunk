using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IgnoreCollide : MonoBehaviour {

	[SerializeField]
	private Collider2D other;

	// Use this for initialization
	private void Awake() {
		Physics2D.IgnoreLayerCollision (8, 11);
	}
}
