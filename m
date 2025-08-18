Return-Path: <linux-sctp+bounces-619-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19885B2B30C
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 22:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423661B2329A
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3027780E;
	Mon, 18 Aug 2025 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzc5Imvs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005C275861;
	Mon, 18 Aug 2025 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550640; cv=none; b=ZSPGFHdcBxB8Lhb0UrCoyZf6gf01REbs6Y6JRcdh6NyTsSgailrkHFLJTiZWTqszlgKXcytBj0BgQ36MRqfNVW+TtnuiuV3BFAGTgP+QmBpoS1zV6ewFsD6eOqWTzLvX6SAj7++woyDbPHoi0T9FwGGl2a4+TJfZ7kO/GapMP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550640; c=relaxed/simple;
	bh=K9z8UBvJu2ArRItWpxxQbAOQ0oc0y9ATD6IZC97GlYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5ALBQCXfTtTNtj6xJU1srgXUWRnyzaMm4DIEK8eV6SzN4R933bakWjG5CvzPlt1NNy3GtcDS99w8tlT6ayG6CmWHlL6mXtLl2uZs+Mvjea9TKDaUmKhSAWLuUJiQIJvVJx/mbdCFneYCOhHNVQdy1xIb3bAzdF/G6o49rdSmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzc5Imvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6687C116C6;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550639;
	bh=K9z8UBvJu2ArRItWpxxQbAOQ0oc0y9ATD6IZC97GlYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mzc5Imvsvknk5Ma0FP5goM78ulVBpblfbcVRpGP1HiahGh5aDtTiXrd7djkcvC0j8
	 UXQ1GQNAaR0jo62sQw0ZqBp6Fn3RC1nhmRCG7nbIqCcgZvgkE0wRFP8AxXQUK8QZRx
	 4gWO6dCDke/j9DBZ+MudkJQseR3e3QIXdQaiwqi5dy+sWN/7bz1RVJK97rInjHCgP+
	 7UQBTfaWx04aD6xNT3u0JYiIIkoqCEpj+1N50NeSpAwYfA2notQ6IBWgamyWBOWT0p
	 Y2uyAn6YY6tuu9jSKm1rFQkiMjoprfVzbpIbF01otLZzU5m7JeYB4UsAvvUWfI9xeV
	 uafitu1EnqxPg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next v3 4/5] sctp: Convert cookie authentication to use HMAC-SHA256
Date: Mon, 18 Aug 2025 13:54:25 -0700
Message-ID: <20250818205426.30222-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818205426.30222-1-ebiggers@kernel.org>
References: <20250818205426.30222-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert SCTP cookies to use HMAC-SHA256, instead of the previous choice
of the legacy algorithms HMAC-MD5 and HMAC-SHA1.  Simplify and optimize
the code by using the HMAC-SHA256 library instead of crypto_shash, and
by preparing the HMAC key when it is generated instead of per-operation.

This doesn't break compatibility, since the cookie format is an
implementation detail, not part of the SCTP protocol itself.

Note that the cookie size doesn't change either.  The HMAC field was
already 32 bytes, even though previously at most 20 bytes were actually
compared.  32 bytes exactly fits an untruncated HMAC-SHA256 value.  So,
although we could safely truncate the MAC to something slightly shorter,
for now just keep the cookie size the same.

I also considered SipHash, but that would generate only 8-byte MACs.  An
8-byte MAC *might* suffice here.  However, there's quite a lot of
information in the SCTP cookies: more than in TCP SYN cookies.  So
absent an analysis that occasional forgeries of all that information is
okay in SCTP, I errored on the side of caution.

Remove HMAC-MD5 and HMAC-SHA1 as options, since the new HMAC-SHA256
option is just better.  It's faster as well as more secure.  For
example, benchmarking on x86_64, cookie authentication is now nearly 3x
as fast as the previous default choice and implementation of HMAC-MD5.

Also just make the kernel always support cookie authentication if SCTP
is supported at all, rather than making it optional in the build.  (It
was sort of optional before, but it didn't really work properly.  E.g.,
a kernel with CONFIG_SCTP_COOKIE_HMAC_MD5=n still supported HMAC-MD5
cookie authentication if CONFIG_CRYPTO_HMAC and CONFIG_CRYPTO_MD5
happened to be enabled in the kconfig for other reasons.)

Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 11 ++---
 include/net/netns/sctp.h               |  4 +-
 include/net/sctp/constants.h           |  5 +--
 include/net/sctp/structs.h             | 30 ++++----------
 net/sctp/Kconfig                       | 43 +++++--------------
 net/sctp/endpointola.c                 | 23 ++++++-----
 net/sctp/protocol.c                    | 11 ++---
 net/sctp/sm_make_chunk.c               | 57 ++++++++------------------
 net/sctp/socket.c                      | 31 +-------------
 net/sctp/sysctl.c                      | 51 ++++++++++-------------
 10 files changed, 79 insertions(+), 187 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 9756d16e3df14..3d6782683eee7 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3506,20 +3506,17 @@ cookie_preserve_enable - BOOLEAN
 cookie_hmac_alg - STRING
 	Select the hmac algorithm used when generating the cookie value sent by
 	a listening sctp socket to a connecting client in the INIT-ACK chunk.
 	Valid values are:
 
-	* md5
-	* sha1
+	* sha256
 	* none
 
-	Ability to assign md5 or sha1 as the selected alg is predicated on the
-	configuration of those algorithms at build time (CONFIG_CRYPTO_MD5 and
-	CONFIG_CRYPTO_SHA1).
+	md5 and sha1 are also accepted for backwards compatibility, but cause
+	sha256 to be selected.
 
-	Default: Dependent on configuration.  MD5 if available, else SHA1 if
-	available, else none.
+	Default: sha256
 
 rcvbuf_policy - INTEGER
 	Determines if the receive buffer is attributed to the socket or to
 	association.   SCTP supports the capability to create multiple
 	associations on a single socket.  When using this capability, it is
diff --git a/include/net/netns/sctp.h b/include/net/netns/sctp.h
index d25cd7a9c5ff8..c0f97f36389e6 100644
--- a/include/net/netns/sctp.h
+++ b/include/net/netns/sctp.h
@@ -73,12 +73,12 @@ struct netns_sctp {
 	int max_burst;
 
 	/* Whether Cookie Preservative is enabled(1) or not(0) */
 	int cookie_preserve_enable;
 
-	/* The namespace default hmac alg */
-	char *sctp_hmac_alg;
+	/* Whether cookie authentication is enabled(1) or not(0) */
+	int cookie_auth_enable;
 
 	/* Valid.Cookie.Life	    - 60  seconds  */
 	unsigned int valid_cookie_life;
 
 	/* Delayed SACK timeout  200ms default*/
diff --git a/include/net/sctp/constants.h b/include/net/sctp/constants.h
index 8e0f4c4f77506..ae3376ba0b991 100644
--- a/include/net/sctp/constants.h
+++ b/include/net/sctp/constants.h
@@ -294,13 +294,12 @@ enum { SCTP_MAX_GABS = 16 };
 #define SCTP_DEFAULT_MAXSEGMENT 1500	/* MTU size, this is the limit
                                          * to which we will raise the P-MTU.
 					 */
 #define SCTP_DEFAULT_MINSEGMENT 512	/* MTU size ... if no mtu disc */
 
-#define SCTP_SECRET_SIZE 32		/* Number of octets in a 256 bits. */
-
-#define SCTP_SIGNATURE_SIZE 20	        /* size of a SLA-1 signature */
+#define SCTP_COOKIE_KEY_SIZE 32	/* size of cookie HMAC key */
+#define SCTP_COOKIE_MAC_SIZE 32	/* size of HMAC field in cookies */
 
 #define SCTP_COOKIE_MULTIPLE 32 /* Pad out our cookie to make our hash
 				 * functions simpler to write.
 				 */
 
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 6be6aec25731e..2ae390219efdd 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -30,10 +30,11 @@
  */
 
 #ifndef __sctp_structs_h__
 #define __sctp_structs_h__
 
+#include <crypto/sha2.h>
 #include <linux/ktime.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/rhashtable-types.h>
 #include <linux/socket.h>	/* linux/in.h needs this!!    */
 #include <linux/in.h>		/* We get struct sockaddr_in. */
@@ -66,11 +67,10 @@ struct sctp_chunk;
 struct sctp_inq;
 struct sctp_outq;
 struct sctp_bind_addr;
 struct sctp_ulpq;
 struct sctp_ep_common;
-struct crypto_shash;
 struct sctp_stream;
 
 
 #include <net/sctp/tsnmap.h>
 #include <net/sctp/ulpevent.h>
@@ -153,14 +153,10 @@ struct sctp_sock {
 	enum sctp_socket_type type;
 
 	/* PF_ family specific functions.  */
 	struct sctp_pf *pf;
 
-	/* Access to HMAC transform. */
-	struct crypto_shash *hmac;
-	char *sctp_hmac_alg;
-
 	/* What is our base endpointer? */
 	struct sctp_endpoint *ep;
 
 	struct sctp_bind_bucket *bind_hash;
 	/* Various Socket Options.  */
@@ -225,11 +221,12 @@ struct sctp_sock {
 		disable_fragments:1,
 		v4mapped:1,
 		frag_interleave:1,
 		recvrcvinfo:1,
 		recvnxtinfo:1,
-		data_ready_signalled:1;
+		data_ready_signalled:1,
+		cookie_auth_enable:1;
 
 	atomic_t pd_mode;
 
 	/* Fields after this point will be skipped on copies, like on accept
 	 * and peeloff operations
@@ -333,11 +330,11 @@ struct sctp_cookie {
 };
 
 
 /* The format of our cookie that we send to our peer. */
 struct sctp_signed_cookie {
-	__u8 signature[SCTP_SECRET_SIZE];
+	__u8 mac[SCTP_COOKIE_MAC_SIZE];
 	__u32 __pad;		/* force sctp_cookie alignment to 64 bits */
 	struct sctp_cookie c;
 } __packed;
 
 /* This is another convenience type to allocate memory for address
@@ -1305,26 +1302,13 @@ struct sctp_endpoint {
 	 *	      is implemented.
 	 */
 	/* This is really a list of struct sctp_association entries. */
 	struct list_head asocs;
 
-	/* Secret Key: A secret key used by this endpoint to compute
-	 *	      the MAC.	This SHOULD be a cryptographic quality
-	 *	      random number with a sufficient length.
-	 *	      Discussion in [RFC1750] can be helpful in
-	 *	      selection of the key.
-	 */
-	__u8 secret_key[SCTP_SECRET_SIZE];
-
- 	/* digest:  This is a digest of the sctp cookie.  This field is
- 	 * 	    only used on the receive path when we try to validate
- 	 * 	    that the cookie has not been tampered with.  We put
- 	 * 	    this here so we pre-allocate this once and can re-use
- 	 * 	    on every receive.
- 	 */
- 	__u8 *digest;
- 
+	/* Cookie authentication key used by this endpoint */
+	struct hmac_sha256_key cookie_auth_key;
+
 	/* sendbuf acct. policy.	*/
 	__u32 sndbuf_policy;
 
 	/* rcvbuf acct. policy.	*/
 	__u32 rcvbuf_policy;
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 09c77b4d161b1..e947646a380cd 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -47,52 +47,29 @@ config SCTP_DBG_OBJCNT
 	  type of objects that are currently allocated.  This is useful for
 	  identifying memory leaks. This debug information can be viewed by
 	  'cat /proc/net/sctp/sctp_dbg_objcnt'
 
 	  If unsure, say N
+
 choice
-	prompt "Default SCTP cookie HMAC encoding"
-	default SCTP_DEFAULT_COOKIE_HMAC_MD5
+	prompt "Default SCTP cookie authentication method"
+	default SCTP_DEFAULT_COOKIE_HMAC_SHA256
 	help
-	  This option sets the default sctp cookie hmac algorithm
-	  when in doubt select 'md5'
+	  This option sets the default SCTP cookie authentication method, for
+	  when a method hasn't been explicitly selected via the
+	  net.sctp.cookie_hmac_alg sysctl.
 
-config SCTP_DEFAULT_COOKIE_HMAC_MD5
-	bool "Enable optional MD5 hmac cookie generation"
-	help
-	  Enable optional MD5 hmac based SCTP cookie generation
-	select SCTP_COOKIE_HMAC_MD5
+	  If unsure, choose the default (HMAC-SHA256).
 
-config SCTP_DEFAULT_COOKIE_HMAC_SHA1
-	bool "Enable optional SHA1 hmac cookie generation"
-	help
-	  Enable optional SHA1 hmac based SCTP cookie generation
-	select SCTP_COOKIE_HMAC_SHA1
+config SCTP_DEFAULT_COOKIE_HMAC_SHA256
+	bool "HMAC-SHA256"
 
 config SCTP_DEFAULT_COOKIE_HMAC_NONE
-	bool "Use no hmac alg in SCTP cookie generation"
-	help
-	  Use no hmac algorithm in SCTP cookie generation
+	bool "None"
 
 endchoice
 
-config SCTP_COOKIE_HMAC_MD5
-	bool "Enable optional MD5 hmac cookie generation"
-	help
-	  Enable optional MD5 hmac based SCTP cookie generation
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_MD5
-
-config SCTP_COOKIE_HMAC_SHA1
-	bool "Enable optional SHA1 hmac cookie generation"
-	help
-	  Enable optional SHA1 hmac based SCTP cookie generation
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA1
-
 config INET_SCTP_DIAG
 	depends on INET_DIAG
 	def_tristate INET_DIAG
 
 
diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
index 7e77b450697c0..31e989dfe8466 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -33,24 +33,29 @@
 #include <net/sctp/sm.h>
 
 /* Forward declarations for internal helpers. */
 static void sctp_endpoint_bh_rcv(struct work_struct *work);
 
+static void gen_cookie_auth_key(struct hmac_sha256_key *key)
+{
+	u8 raw_key[SCTP_COOKIE_KEY_SIZE];
+
+	get_random_bytes(raw_key, sizeof(raw_key));
+	hmac_sha256_preparekey(key, raw_key, sizeof(raw_key));
+	memzero_explicit(raw_key, sizeof(raw_key));
+}
+
 /*
  * Initialize the base fields of the endpoint structure.
  */
 static struct sctp_endpoint *sctp_endpoint_init(struct sctp_endpoint *ep,
 						struct sock *sk,
 						gfp_t gfp)
 {
 	struct net *net = sock_net(sk);
 	struct sctp_shared_key *null_key;
 
-	ep->digest = kzalloc(SCTP_SIGNATURE_SIZE, gfp);
-	if (!ep->digest)
-		return NULL;
-
 	ep->asconf_enable = net->sctp.addip_enable;
 	ep->auth_enable = net->sctp.auth_enable;
 	if (ep->auth_enable) {
 		if (sctp_auth_init(ep, gfp))
 			goto nomem;
@@ -88,12 +93,12 @@ static struct sctp_endpoint *sctp_endpoint_init(struct sctp_endpoint *ep,
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
 	/* Get the receive buffer policy for this endpoint */
 	ep->rcvbuf_policy = net->sctp.rcvbuf_policy;
 
-	/* Initialize the secret key used with cookie. */
-	get_random_bytes(ep->secret_key, sizeof(ep->secret_key));
+	/* Generate the cookie authentication key. */
+	gen_cookie_auth_key(&ep->cookie_auth_key);
 
 	/* SCTP-AUTH extensions*/
 	INIT_LIST_HEAD(&ep->endpoint_shared_keys);
 	null_key = sctp_auth_shkey_create(0, gfp);
 	if (!null_key)
@@ -116,11 +121,10 @@ static struct sctp_endpoint *sctp_endpoint_init(struct sctp_endpoint *ep,
 	return ep;
 
 nomem_shkey:
 	sctp_auth_free(ep);
 nomem:
-	kfree(ep->digest);
 	return NULL;
 
 }
 
 /* Create a sctp_endpoint with all that boring stuff initialized.
@@ -203,24 +207,21 @@ static void sctp_endpoint_destroy(struct sctp_endpoint *ep)
 	if (unlikely(!ep->base.dead)) {
 		WARN(1, "Attempt to destroy undead endpoint %p!\n", ep);
 		return;
 	}
 
-	/* Free the digest buffer */
-	kfree(ep->digest);
-
 	/* SCTP-AUTH: Free up AUTH releated data such as shared keys
 	 * chunks and hmacs arrays that were allocated
 	 */
 	sctp_auth_destroy_keys(&ep->endpoint_shared_keys);
 	sctp_auth_free(ep);
 
 	/* Cleanup. */
 	sctp_inq_free(&ep->base.inqueue);
 	sctp_bind_addr_free(&ep->base.bind_addr);
 
-	memset(ep->secret_key, 0, sizeof(ep->secret_key));
+	memzero_explicit(&ep->cookie_auth_key, sizeof(ep->cookie_auth_key));
 
 	sk = ep->base.sk;
 	/* Remove and free the port */
 	if (sctp_sk(sk)->bind_hash)
 		sctp_put_port(sk);
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index a5ccada55f2b2..3b2373b3bd5df 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1332,18 +1332,13 @@ static int __net_init sctp_defaults_init(struct net *net)
 	net->sctp.valid_cookie_life		= SCTP_DEFAULT_COOKIE_LIFE;
 
 	/* Whether Cookie Preservative is enabled(1) or not(0) */
 	net->sctp.cookie_preserve_enable 	= 1;
 
-	/* Default sctp sockets to use md5 as their hmac alg */
-#if defined (CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5)
-	net->sctp.sctp_hmac_alg			= "md5";
-#elif defined (CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1)
-	net->sctp.sctp_hmac_alg			= "sha1";
-#else
-	net->sctp.sctp_hmac_alg			= NULL;
-#endif
+	/* Whether cookie authentication is enabled(1) or not(0) */
+	net->sctp.cookie_auth_enable =
+		!IS_ENABLED(CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE);
 
 	/* Max.Burst		    - 4 */
 	net->sctp.max_burst			= SCTP_DEFAULT_MAX_BURST;
 
 	/* Disable of Primary Path Switchover by default */
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index a1a3c8494c5d2..2c0017d058d40 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -28,11 +28,10 @@
  *    Kevin Gao             <kevin.gao@intel.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <crypto/hash.h>
 #include <crypto/utils.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -1673,12 +1672,14 @@ static struct sctp_cookie_param *sctp_pack_cookie(
 
 	/* Clear this memory since we are sending this data structure
 	 * out on the network.
 	 */
 	retval = kzalloc(*cookie_len, GFP_ATOMIC);
-	if (!retval)
-		goto nodata;
+	if (!retval) {
+		*cookie_len = 0;
+		return NULL;
+	}
 
 	cookie = (struct sctp_signed_cookie *) retval->body;
 
 	/* Set up the parameter header.  */
 	retval->p.type = SCTP_PARAM_STATE_COOKIE;
@@ -1705,30 +1706,18 @@ static struct sctp_cookie_param *sctp_pack_cookie(
 
 	/* Copy the raw local address list of the association. */
 	memcpy((__u8 *)(cookie + 1) +
 	       ntohs(init_chunk->chunk_hdr->length), raw_addrs, addrs_len);
 
-	if (sctp_sk(ep->base.sk)->hmac) {
-		struct crypto_shash *tfm = sctp_sk(ep->base.sk)->hmac;
-		int err;
-
-		/* Sign the message.  */
-		err = crypto_shash_setkey(tfm, ep->secret_key,
-					  sizeof(ep->secret_key)) ?:
-		      crypto_shash_tfm_digest(tfm, (u8 *)&cookie->c, bodysize,
-					      cookie->signature);
-		if (err)
-			goto free_cookie;
+	/* Sign the cookie, if cookie authentication is enabled. */
+	if (sctp_sk(ep->base.sk)->cookie_auth_enable) {
+		static_assert(sizeof(cookie->mac) == SHA256_DIGEST_SIZE);
+		hmac_sha256(&ep->cookie_auth_key, (const u8 *)&cookie->c,
+			    bodysize, cookie->mac);
 	}
 
 	return retval;
-
-free_cookie:
-	kfree(retval);
-nodata:
-	*cookie_len = 0;
-	return NULL;
 }
 
 /* Unpack the cookie from COOKIE ECHO chunk, recreating the association.  */
 struct sctp_association *sctp_unpack_cookie(
 					const struct sctp_endpoint *ep,
@@ -1739,11 +1728,10 @@ struct sctp_association *sctp_unpack_cookie(
 	struct sctp_association *retval = NULL;
 	int headersize, bodysize, fixed_size;
 	struct sctp_signed_cookie *cookie;
 	struct sk_buff *skb = chunk->skb;
 	struct sctp_cookie *bear_cookie;
-	__u8 *digest = ep->digest;
 	enum sctp_scope scope;
 	unsigned int len;
 	ktime_t kt;
 
 	/* Header size is static data prior to the actual cookie, including
@@ -1769,34 +1757,23 @@ struct sctp_association *sctp_unpack_cookie(
 
 	/* Process the cookie.  */
 	cookie = chunk->subh.cookie_hdr;
 	bear_cookie = &cookie->c;
 
-	if (!sctp_sk(ep->base.sk)->hmac)
-		goto no_hmac;
+	/* Verify the cookie's MAC, if cookie authentication is enabled. */
+	if (sctp_sk(ep->base.sk)->cookie_auth_enable) {
+		u8 mac[SHA256_DIGEST_SIZE];
 
-	/* Check the signature.  */
-	{
-		struct crypto_shash *tfm = sctp_sk(ep->base.sk)->hmac;
-		int err;
-
-		err = crypto_shash_setkey(tfm, ep->secret_key,
-					  sizeof(ep->secret_key)) ?:
-		      crypto_shash_tfm_digest(tfm, (u8 *)bear_cookie, bodysize,
-					      digest);
-		if (err) {
-			*error = -SCTP_IERROR_NOMEM;
+		hmac_sha256(&ep->cookie_auth_key, (const u8 *)bear_cookie,
+			    bodysize, mac);
+		static_assert(sizeof(cookie->mac) == sizeof(mac));
+		if (crypto_memneq(mac, cookie->mac, sizeof(mac))) {
+			*error = -SCTP_IERROR_BAD_SIG;
 			goto fail;
 		}
 	}
 
-	if (crypto_memneq(digest, cookie->signature, SCTP_SIGNATURE_SIZE)) {
-		*error = -SCTP_IERROR_BAD_SIG;
-		goto fail;
-	}
-
-no_hmac:
 	/* IG Section 2.35.2:
 	 *  3) Compare the port numbers and the verification tag contained
 	 *     within the COOKIE ECHO chunk to the actual port numbers and the
 	 *     verification tag within the SCTP common header of the received
 	 *     packet. If these values do not match the packet MUST be silently
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 0292881a847ca..ed8293a342402 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -35,11 +35,10 @@
  *    Kevin Gao             <kevin.gao@intel.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <crypto/hash.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/wait.h>
 #include <linux/time.h>
 #include <linux/sched/signal.h>
@@ -4985,11 +4984,11 @@ static int sctp_init_sock(struct sock *sk)
 	sp->default_timetolive = 0;
 
 	sp->default_rcv_context = 0;
 	sp->max_burst = net->sctp.max_burst;
 
-	sp->sctp_hmac_alg = net->sctp.sctp_hmac_alg;
+	sp->cookie_auth_enable = net->sctp.cookie_auth_enable;
 
 	/* Initialize default setup parameters. These parameters
 	 * can be modified with the SCTP_INITMSG socket option or
 	 * overridden by the SCTP_INIT CMSG.
 	 */
@@ -5077,12 +5076,10 @@ static int sctp_init_sock(struct sock *sk)
 	 */
 	sp->ep = sctp_endpoint_new(sk, GFP_KERNEL);
 	if (!sp->ep)
 		return -ENOMEM;
 
-	sp->hmac = NULL;
-
 	sk->sk_destruct = sctp_destruct_sock;
 
 	SCTP_DBG_OBJCNT_INC(sock);
 
 	sk_sockets_allocated_inc(sk);
@@ -5115,22 +5112,12 @@ static void sctp_destroy_sock(struct sock *sk)
 	sctp_endpoint_free(sp->ep);
 	sk_sockets_allocated_dec(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 }
 
-/* Triggered when there are no references on the socket anymore */
-static void sctp_destruct_common(struct sock *sk)
-{
-	struct sctp_sock *sp = sctp_sk(sk);
-
-	/* Free up the HMAC transform. */
-	crypto_free_shash(sp->hmac);
-}
-
 static void sctp_destruct_sock(struct sock *sk)
 {
-	sctp_destruct_common(sk);
 	inet_sock_destruct(sk);
 }
 
 /* API 4.1.7 shutdown() - TCP Style Syntax
  *     int shutdown(int socket, int how);
@@ -8528,26 +8515,12 @@ static int sctp_get_port(struct sock *sk, unsigned short snum)
  */
 static int sctp_listen_start(struct sock *sk, int backlog)
 {
 	struct sctp_sock *sp = sctp_sk(sk);
 	struct sctp_endpoint *ep = sp->ep;
-	struct crypto_shash *tfm = NULL;
-	char alg[32];
 	int err;
 
-	/* Allocate HMAC for generating cookie. */
-	if (!sp->hmac && sp->sctp_hmac_alg) {
-		sprintf(alg, "hmac(%s)", sp->sctp_hmac_alg);
-		tfm = crypto_alloc_shash(alg, 0, 0);
-		if (IS_ERR(tfm)) {
-			net_info_ratelimited("failed to load transform for %s: %ld\n",
-					     sp->sctp_hmac_alg, PTR_ERR(tfm));
-			return -ENOSYS;
-		}
-		sctp_sk(sk)->hmac = tfm;
-	}
-
 	/*
 	 * If a bind() or sctp_bindx() is not called prior to a listen()
 	 * call that allows new associations to be accepted, the system
 	 * picks an ephemeral port and will choose an address set equivalent
 	 * to binding with a wildcard address.
@@ -9559,11 +9532,10 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 
 	/* Restore the ep value that was overwritten with the above structure
 	 * copy.
 	 */
 	newsp->ep = newep;
-	newsp->hmac = NULL;
 
 	/* Hook this new socket in to the bind_hash list. */
 	head = &sctp_port_hashtable[sctp_phashfn(sock_net(oldsk),
 						 inet_sk(oldsk)->inet_num)];
 	spin_lock_bh(&head->lock);
@@ -9711,11 +9683,10 @@ struct proto sctp_prot = {
 
 #if IS_ENABLED(CONFIG_IPV6)
 
 static void sctp_v6_destruct_sock(struct sock *sk)
 {
-	sctp_destruct_common(sk);
 	inet6_sock_destruct(sk);
 }
 
 static int sctp_v6_init_sock(struct sock *sk)
 {
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index ee3eac338a9de..19acc57c3ed97 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -172,11 +172,11 @@ static struct ctl_table sctp_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "cookie_hmac_alg",
-		.data		= &init_net.sctp.sctp_hmac_alg,
+		.data		= &init_net.sctp.cookie_auth_enable,
 		.maxlen		= 8,
 		.mode		= 0644,
 		.proc_handler	= proc_sctp_do_hmac_alg,
 	},
 	{
@@ -386,50 +386,41 @@ static struct ctl_table sctp_net_table[] = {
 
 static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net,
-				       sctp.sctp_hmac_alg);
+				       sctp.cookie_auth_enable);
 	struct ctl_table tbl;
-	bool changed = false;
-	char *none = "none";
 	char tmp[8] = {0};
 	int ret;
 
 	memset(&tbl, 0, sizeof(struct ctl_table));
 
 	if (write) {
 		tbl.data = tmp;
-		tbl.maxlen = sizeof(tmp);
-	} else {
-		tbl.data = net->sctp.sctp_hmac_alg ? : none;
-		tbl.maxlen = strlen(tbl.data);
-	}
-
-	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
-	if (write && ret == 0) {
-#ifdef CONFIG_CRYPTO_MD5
-		if (!strncmp(tmp, "md5", 3)) {
-			net->sctp.sctp_hmac_alg = "md5";
-			changed = true;
+		tbl.maxlen = sizeof(tmp) - 1;
+		ret = proc_dostring(&tbl, 1, buffer, lenp, ppos);
+		if (ret)
+			return ret;
+		if (!strcmp(tmp, "sha256") ||
+		    /* for backwards compatibility */
+		    !strcmp(tmp, "md5") || !strcmp(tmp, "sha1")) {
+			net->sctp.cookie_auth_enable = 1;
+			return 0;
 		}
-#endif
-#ifdef CONFIG_CRYPTO_SHA1
-		if (!strncmp(tmp, "sha1", 4)) {
-			net->sctp.sctp_hmac_alg = "sha1";
-			changed = true;
+		if (!strcmp(tmp, "none")) {
+			net->sctp.cookie_auth_enable = 0;
+			return 0;
 		}
-#endif
-		if (!strncmp(tmp, "none", 4)) {
-			net->sctp.sctp_hmac_alg = NULL;
-			changed = true;
-		}
-		if (!changed)
-			ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
+	if (net->sctp.cookie_auth_enable)
+		tbl.data = (char *)"sha256";
+	else
+		tbl.data = (char *)"none";
+	tbl.maxlen = strlen(tbl.data);
+	return proc_dostring(&tbl, 0, buffer, lenp, ppos);
 }
 
 static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-- 
2.50.1


