Return-Path: <linux-sctp+bounces-599-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F95BB21577
	for <lists+linux-sctp@lfdr.de>; Mon, 11 Aug 2025 21:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21552190766B
	for <lists+linux-sctp@lfdr.de>; Mon, 11 Aug 2025 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A42D876C;
	Mon, 11 Aug 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx68i1Wq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A02D63E5;
	Mon, 11 Aug 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941214; cv=none; b=bdMi0l2v6o3F5zppBDV6jYA5bLf5YayayCrGhDh4sUouKUtLCtDOBeh1kjMhUG2Z0zUoNK7vvPv2872oDEoPCjx7Gl2M81zoPdtp00h1YjqW9USQJBpcWWZiMAbq63yoM5PAqaq3SPkN++5KEZPsMGK47BAsapwgv44QGu6laBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941214; c=relaxed/simple;
	bh=r3HQx+obV5VfhTb4WHp+CPJkyD/52Eudc4JpPtKoOt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4R26JKIChIYM4HEPOpMBklhAbgP2/brbCn7Aruuy9J6zPajCoz7uCD1u9zvh1E1zOD0EtOnTAE5D60i3ZHtc6sqnCKh3FQ7zjC2ImDuoLqyix1mXqxjGutfO/4qYoMTlzt/fItOyrTS1ZFIaEA2mGh08Flw3X2RxDOnGE5S3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx68i1Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DFCC4CEF6;
	Mon, 11 Aug 2025 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941214;
	bh=r3HQx+obV5VfhTb4WHp+CPJkyD/52Eudc4JpPtKoOt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bx68i1WqoRpwwJ8f8CQJZbWJH3FWiAci4seVtEJXVCyMAaf1mRDN5ePPndUMNZ9z+
	 io9jh67c1V61H/Bu7bIj0NawLclTRDQR3od2bUhN5klV0HtdEZPWkNzazUBngmqqp9
	 lUCSmcGdeK7VH8VYb7DZe8ED+8I6ITzPaPp4yT96wxveQV002j+4PqeanMOy44bddl
	 KHRSfiG6Lzpv4otnksh/3UK/SzRMoyjyBk55QoQMDSYbGRrANvuUYFtEhJBM1c3+l7
	 Uasd+OSncsJ04SZb6lJZkgOdTxdnYGVTDiIrpvaCgsTZJ9nLemFTJ72+t/lfNX90Z+
	 oP02GrqbTEaEw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 1/2] sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
Date: Mon, 11 Aug 2025 12:37:40 -0700
Message-ID: <20250811193741.412592-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811193741.412592-1-ebiggers@kernel.org>
References: <20250811193741.412592-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For SCTP chunk authentication, use the HMAC-SHA1 and HMAC-SHA256 library
functions instead of crypto_shash.  This is simpler and faster.  There's
no longer any need to pre-allocate 'crypto_shash' objects; the SCTP code
now simply calls into the HMAC code directly.

As part of this, make SCTP always support both HMAC-SHA1 and
HMAC-SHA256.  Previously, it only guaranteed support for HMAC-SHA1.
However, HMAC-SHA256 tended to be supported too anyway, as it was
supported if CONFIG_CRYPTO_SHA256 was enabled elsewhere in the kconfig.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/net/sctp/auth.h      |  17 ++--
 include/net/sctp/constants.h |   4 -
 include/net/sctp/structs.h   |   5 --
 net/sctp/Kconfig             |  15 ++--
 net/sctp/auth.c              | 166 ++++++-----------------------------
 net/sctp/chunk.c             |   3 +-
 net/sctp/sm_make_chunk.c     |   2 +-
 net/sctp/sm_statefuns.c      |   2 +-
 net/sctp/socket.c            |  10 ---
 9 files changed, 47 insertions(+), 177 deletions(-)

diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
index d4b3b2dcd15b7..3d5879e08e78a 100644
--- a/include/net/sctp/auth.h
+++ b/include/net/sctp/auth.h
@@ -20,20 +20,15 @@
 
 struct sctp_endpoint;
 struct sctp_association;
 struct sctp_authkey;
 struct sctp_hmacalgo;
-struct crypto_shash;
 
-/*
- * Define a generic struct that will hold all the info
- * necessary for an HMAC transform
- */
+/* Defines an HMAC algorithm supported by SCTP chunk authentication */
 struct sctp_hmac {
-	__u16 hmac_id;		/* one of the above ids */
-	char *hmac_name;	/* name for loading */
-	__u16 hmac_len;		/* length of the signature */
+	__u16 hmac_id;		/* one of SCTP_AUTH_HMAC_ID_* */
+	__u16 hmac_len;		/* length of the HMAC value in bytes */
 };
 
 /* This is generic structure that containst authentication bytes used
  * as keying material.  It's a what is referred to as byte-vector all
  * over SCTP-AUTH
@@ -76,13 +71,13 @@ struct sctp_shared_key *sctp_auth_get_shkey(
 				__u16 key_id);
 int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
 				struct sctp_association *asoc,
 				gfp_t gfp);
 int sctp_auth_init_hmacs(struct sctp_endpoint *ep, gfp_t gfp);
-void sctp_auth_destroy_hmacs(struct crypto_shash *auth_hmacs[]);
-struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id);
-struct sctp_hmac *sctp_auth_asoc_get_hmac(const struct sctp_association *asoc);
+const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id);
+const struct sctp_hmac *
+sctp_auth_asoc_get_hmac(const struct sctp_association *asoc);
 void sctp_auth_asoc_set_default_hmac(struct sctp_association *asoc,
 				     struct sctp_hmac_algo_param *hmacs);
 int sctp_auth_asoc_verify_hmac_id(const struct sctp_association *asoc,
 				    __be16 hmac_id);
 int sctp_auth_send_cid(enum sctp_cid chunk,
diff --git a/include/net/sctp/constants.h b/include/net/sctp/constants.h
index 5859e0a16a584..8e0f4c4f77506 100644
--- a/include/net/sctp/constants.h
+++ b/include/net/sctp/constants.h
@@ -415,20 +415,16 @@ enum sctp_lower_cwnd {
  */
 enum {
 	SCTP_AUTH_HMAC_ID_RESERVED_0,
 	SCTP_AUTH_HMAC_ID_SHA1,
 	SCTP_AUTH_HMAC_ID_RESERVED_2,
-#if defined (CONFIG_CRYPTO_SHA256) || defined (CONFIG_CRYPTO_SHA256_MODULE)
 	SCTP_AUTH_HMAC_ID_SHA256,
-#endif
 	__SCTP_AUTH_HMAC_MAX
 };
 
 #define SCTP_AUTH_HMAC_ID_MAX	__SCTP_AUTH_HMAC_MAX - 1
 #define SCTP_AUTH_NUM_HMACS 	__SCTP_AUTH_HMAC_MAX
-#define SCTP_SHA1_SIG_SIZE 20
-#define SCTP_SHA256_SIG_SIZE 32
 
 /*  SCTP-AUTH, Section 3.2
  *     The chunk types for INIT, INIT-ACK, SHUTDOWN-COMPLETE and AUTH chunks
  *     MUST NOT be listed in the CHUNKS parameter
  */
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 8a540ad9b5090..6be6aec25731e 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1327,15 +1327,10 @@ struct sctp_endpoint {
 	__u32 sndbuf_policy;
 
 	/* rcvbuf acct. policy.	*/
 	__u32 rcvbuf_policy;
 
-	/* SCTP AUTH: array of the HMACs that will be allocated
-	 * we need this per association so that we don't serialize
-	 */
-	struct crypto_shash **auth_hmacs;
-
 	/* SCTP-AUTH: hmacs for the endpoint encoded into parameter */
 	 struct sctp_hmac_algo_param *auth_hmacs_list;
 
 	/* SCTP-AUTH: chunks to authenticate encoded into parameter */
 	struct sctp_chunks_param *auth_chunk_list;
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 24d5a35ce894a..192027555b4d8 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -5,13 +5,12 @@
 
 menuconfig IP_SCTP
 	tristate "The SCTP Protocol"
 	depends on INET
 	depends on IPV6 || IPV6=n
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA1
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
 	select NET_CRC32C
 	select NET_UDP_TUNNEL
 	help
 	  Stream Control Transmission Protocol
 
@@ -77,19 +76,21 @@ endchoice
 
 config SCTP_COOKIE_HMAC_MD5
 	bool "Enable optional MD5 hmac cookie generation"
 	help
 	  Enable optional MD5 hmac based SCTP cookie generation
-	select CRYPTO_HMAC if SCTP_COOKIE_HMAC_MD5
-	select CRYPTO_MD5 if SCTP_COOKIE_HMAC_MD5
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_MD5
 
 config SCTP_COOKIE_HMAC_SHA1
 	bool "Enable optional SHA1 hmac cookie generation"
 	help
 	  Enable optional SHA1 hmac based SCTP cookie generation
-	select CRYPTO_HMAC if SCTP_COOKIE_HMAC_SHA1
-	select CRYPTO_SHA1 if SCTP_COOKIE_HMAC_SHA1
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_SHA1
 
 config INET_SCTP_DIAG
 	depends on INET_DIAG
 	def_tristate INET_DIAG
 
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index c58fffc86a0c2..82aad477590e2 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -10,40 +10,41 @@
  *
  * Written or modified by:
  *   Vlad Yasevich     <vladislav.yasevich@hp.com>
  */
 
-#include <crypto/hash.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/scatterlist.h>
 #include <net/sctp/sctp.h>
 #include <net/sctp/auth.h>
 
-static struct sctp_hmac sctp_hmac_list[SCTP_AUTH_NUM_HMACS] = {
+static const struct sctp_hmac sctp_hmac_list[SCTP_AUTH_NUM_HMACS] = {
 	{
 		/* id 0 is reserved.  as all 0 */
 		.hmac_id = SCTP_AUTH_HMAC_ID_RESERVED_0,
 	},
 	{
 		.hmac_id = SCTP_AUTH_HMAC_ID_SHA1,
-		.hmac_name = "hmac(sha1)",
-		.hmac_len = SCTP_SHA1_SIG_SIZE,
+		.hmac_len = SHA1_DIGEST_SIZE,
 	},
 	{
 		/* id 2 is reserved as well */
 		.hmac_id = SCTP_AUTH_HMAC_ID_RESERVED_2,
 	},
-#if IS_ENABLED(CONFIG_CRYPTO_SHA256)
 	{
 		.hmac_id = SCTP_AUTH_HMAC_ID_SHA256,
-		.hmac_name = "hmac(sha256)",
-		.hmac_len = SCTP_SHA256_SIG_SIZE,
+		.hmac_len = SHA256_DIGEST_SIZE,
 	}
-#endif
 };
 
+static bool sctp_hmac_supported(__u16 hmac_id)
+{
+	return hmac_id < ARRAY_SIZE(sctp_hmac_list) &&
+	       sctp_hmac_list[hmac_id].hmac_len != 0;
+}
 
 void sctp_auth_key_put(struct sctp_auth_bytes *key)
 {
 	if (!key)
 		return;
@@ -442,88 +443,20 @@ struct sctp_shared_key *sctp_auth_get_shkey(
 	}
 
 	return NULL;
 }
 
-/*
- * Initialize all the possible digest transforms that we can use.  Right
- * now, the supported digests are SHA1 and SHA256.  We do this here once
- * because of the restrictiong that transforms may only be allocated in
- * user context.  This forces us to pre-allocated all possible transforms
- * at the endpoint init time.
- */
-int sctp_auth_init_hmacs(struct sctp_endpoint *ep, gfp_t gfp)
-{
-	struct crypto_shash *tfm = NULL;
-	__u16   id;
-
-	/* If the transforms are already allocated, we are done */
-	if (ep->auth_hmacs)
-		return 0;
-
-	/* Allocated the array of pointers to transorms */
-	ep->auth_hmacs = kcalloc(SCTP_AUTH_NUM_HMACS,
-				 sizeof(struct crypto_shash *),
-				 gfp);
-	if (!ep->auth_hmacs)
-		return -ENOMEM;
-
-	for (id = 0; id < SCTP_AUTH_NUM_HMACS; id++) {
-
-		/* See is we support the id.  Supported IDs have name and
-		 * length fields set, so that we can allocated and use
-		 * them.  We can safely just check for name, for without the
-		 * name, we can't allocate the TFM.
-		 */
-		if (!sctp_hmac_list[id].hmac_name)
-			continue;
-
-		/* If this TFM has been allocated, we are all set */
-		if (ep->auth_hmacs[id])
-			continue;
-
-		/* Allocate the ID */
-		tfm = crypto_alloc_shash(sctp_hmac_list[id].hmac_name, 0, 0);
-		if (IS_ERR(tfm))
-			goto out_err;
-
-		ep->auth_hmacs[id] = tfm;
-	}
-
-	return 0;
-
-out_err:
-	/* Clean up any successful allocations */
-	sctp_auth_destroy_hmacs(ep->auth_hmacs);
-	ep->auth_hmacs = NULL;
-	return -ENOMEM;
-}
-
-/* Destroy the hmac tfm array */
-void sctp_auth_destroy_hmacs(struct crypto_shash *auth_hmacs[])
-{
-	int i;
-
-	if (!auth_hmacs)
-		return;
-
-	for (i = 0; i < SCTP_AUTH_NUM_HMACS; i++) {
-		crypto_free_shash(auth_hmacs[i]);
-	}
-	kfree(auth_hmacs);
-}
-
-
-struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id)
+const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id)
 {
 	return &sctp_hmac_list[hmac_id];
 }
 
 /* Get an hmac description information that we can use to build
  * the AUTH chunk
  */
-struct sctp_hmac *sctp_auth_asoc_get_hmac(const struct sctp_association *asoc)
+const struct sctp_hmac *
+sctp_auth_asoc_get_hmac(const struct sctp_association *asoc)
 {
 	struct sctp_hmac_algo_param *hmacs;
 	__u16 n_elt;
 	__u16 id = 0;
 	int i;
@@ -541,30 +474,14 @@ struct sctp_hmac *sctp_auth_asoc_get_hmac(const struct sctp_association *asoc)
 
 	n_elt = (ntohs(hmacs->param_hdr.length) -
 		 sizeof(struct sctp_paramhdr)) >> 1;
 	for (i = 0; i < n_elt; i++) {
 		id = ntohs(hmacs->hmac_ids[i]);
-
-		/* Check the id is in the supported range. And
-		 * see if we support the id.  Supported IDs have name and
-		 * length fields set, so that we can allocate and use
-		 * them.  We can safely just check for name, for without the
-		 * name, we can't allocate the TFM.
-		 */
-		if (id > SCTP_AUTH_HMAC_ID_MAX ||
-		    !sctp_hmac_list[id].hmac_name) {
-			id = 0;
-			continue;
-		}
-
-		break;
+		if (sctp_hmac_supported(id))
+			return &sctp_hmac_list[id];
 	}
-
-	if (id == 0)
-		return NULL;
-
-	return &sctp_hmac_list[id];
+	return NULL;
 }
 
 static int __sctp_auth_find_hmacid(__be16 *hmacs, int n_elts, __be16 hmac_id)
 {
 	int  found = 0;
@@ -604,31 +521,23 @@ int sctp_auth_asoc_verify_hmac_id(const struct sctp_association *asoc,
  *   algorithm it supports.
  */
 void sctp_auth_asoc_set_default_hmac(struct sctp_association *asoc,
 				     struct sctp_hmac_algo_param *hmacs)
 {
-	struct sctp_endpoint *ep;
 	__u16   id;
 	int	i;
 	int	n_params;
 
 	/* if the default id is already set, use it */
 	if (asoc->default_hmac_id)
 		return;
 
 	n_params = (ntohs(hmacs->param_hdr.length) -
 		    sizeof(struct sctp_paramhdr)) >> 1;
-	ep = asoc->ep;
 	for (i = 0; i < n_params; i++) {
 		id = ntohs(hmacs->hmac_ids[i]);
-
-		/* Check the id is in the supported range */
-		if (id > SCTP_AUTH_HMAC_ID_MAX)
-			continue;
-
-		/* If this TFM has been allocated, use this id */
-		if (ep->auth_hmacs[id]) {
+		if (sctp_hmac_supported(id)) {
 			asoc->default_hmac_id = id;
 			break;
 		}
 	}
 }
@@ -707,14 +616,13 @@ int sctp_auth_recv_cid(enum sctp_cid chunk, const struct sctp_association *asoc)
 void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
 			      struct sk_buff *skb, struct sctp_auth_chunk *auth,
 			      struct sctp_shared_key *ep_key, gfp_t gfp)
 {
 	struct sctp_auth_bytes *asoc_key;
-	struct crypto_shash *tfm;
 	__u16 key_id, hmac_id;
-	unsigned char *end;
 	int free_key = 0;
+	size_t data_len;
 	__u8 *digest;
 
 	/* Extract the info we need:
 	 * - hmac id
 	 * - key id
@@ -731,23 +639,21 @@ void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
 			return;
 
 		free_key = 1;
 	}
 
-	/* set up scatter list */
-	end = skb_tail_pointer(skb);
-
-	tfm = asoc->ep->auth_hmacs[hmac_id];
-
+	data_len = skb_tail_pointer(skb) - (unsigned char *)auth;
 	digest = (u8 *)(&auth->auth_hdr + 1);
-	if (crypto_shash_setkey(tfm, &asoc_key->data[0], asoc_key->len))
-		goto free;
-
-	crypto_shash_tfm_digest(tfm, (u8 *)auth, end - (unsigned char *)auth,
-				digest);
+	if (hmac_id == SCTP_AUTH_HMAC_ID_SHA1) {
+		hmac_sha1_usingrawkey(asoc_key->data, asoc_key->len,
+				      (const u8 *)auth, data_len, digest);
+	} else {
+		WARN_ON_ONCE(hmac_id != SCTP_AUTH_HMAC_ID_SHA256);
+		hmac_sha256_usingrawkey(asoc_key->data, asoc_key->len,
+					(const u8 *)auth, data_len, digest);
+	}
 
-free:
 	if (free_key)
 		sctp_auth_key_put(asoc_key);
 }
 
 /* API Helpers */
@@ -786,18 +692,15 @@ int sctp_auth_ep_set_hmacs(struct sctp_endpoint *ep,
 	 * SHA1 is specified.
 	 */
 	for (i = 0; i < hmacs->shmac_num_idents; i++) {
 		id = hmacs->shmac_idents[i];
 
-		if (id > SCTP_AUTH_HMAC_ID_MAX)
+		if (!sctp_hmac_supported(id))
 			return -EOPNOTSUPP;
 
 		if (SCTP_AUTH_HMAC_ID_SHA1 == id)
 			has_sha1 = 1;
-
-		if (!sctp_hmac_list[id].hmac_name)
-			return -EOPNOTSUPP;
 	}
 
 	if (!has_sha1)
 		return -EINVAL;
 
@@ -1019,12 +922,10 @@ int sctp_auth_deact_key_id(struct sctp_endpoint *ep,
 	return 0;
 }
 
 int sctp_auth_init(struct sctp_endpoint *ep, gfp_t gfp)
 {
-	int err = -ENOMEM;
-
 	/* Allocate space for HMACS and CHUNKS authentication
 	 * variables.  There are arrays that we encode directly
 	 * into parameters to make the rest of the operations easier.
 	 */
 	if (!ep->auth_hmacs_list) {
@@ -1058,32 +959,23 @@ int sctp_auth_init(struct sctp_endpoint *ep, gfp_t gfp)
 		auth_chunks->param_hdr.length =
 				htons(sizeof(struct sctp_paramhdr));
 		ep->auth_chunk_list = auth_chunks;
 	}
 
-	/* Allocate and initialize transorms arrays for supported
-	 * HMACs.
-	 */
-	err = sctp_auth_init_hmacs(ep, gfp);
-	if (err)
-		goto nomem;
-
 	return 0;
 
 nomem:
 	/* Free all allocations */
 	kfree(ep->auth_hmacs_list);
 	kfree(ep->auth_chunk_list);
 	ep->auth_hmacs_list = NULL;
 	ep->auth_chunk_list = NULL;
-	return err;
+	return -ENOMEM;
 }
 
 void sctp_auth_free(struct sctp_endpoint *ep)
 {
 	kfree(ep->auth_hmacs_list);
 	kfree(ep->auth_chunk_list);
 	ep->auth_hmacs_list = NULL;
 	ep->auth_chunk_list = NULL;
-	sctp_auth_destroy_hmacs(ep->auth_hmacs);
-	ep->auth_hmacs = NULL;
 }
diff --git a/net/sctp/chunk.c b/net/sctp/chunk.c
index fd4f8243cc35f..c655b571ca01b 100644
--- a/net/sctp/chunk.c
+++ b/net/sctp/chunk.c
@@ -182,11 +182,12 @@ struct sctp_datamsg *sctp_datamsg_from_user(struct sctp_association *asoc,
 	/* If the peer requested that we authenticate DATA chunks
 	 * we need to account for bundling of the AUTH chunks along with
 	 * DATA.
 	 */
 	if (sctp_auth_send_cid(SCTP_CID_DATA, asoc)) {
-		struct sctp_hmac *hmac_desc = sctp_auth_asoc_get_hmac(asoc);
+		const struct sctp_hmac *hmac_desc =
+			sctp_auth_asoc_get_hmac(asoc);
 
 		if (hmac_desc)
 			max_data -= SCTP_PAD4(sizeof(struct sctp_auth_chunk) +
 					      hmac_desc->hmac_len);
 
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 3ead591c72fd3..6961607379191 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1317,11 +1317,11 @@ struct sctp_chunk *sctp_make_op_error(const struct sctp_association *asoc,
 
 struct sctp_chunk *sctp_make_auth(const struct sctp_association *asoc,
 				  __u16 key_id)
 {
 	struct sctp_authhdr auth_hdr;
-	struct sctp_hmac *hmac_desc;
+	const struct sctp_hmac *hmac_desc;
 	struct sctp_chunk *retval;
 
 	/* Get the first hmac that the peer told us to use */
 	hmac_desc = sctp_auth_asoc_get_hmac(asoc);
 	if (unlikely(!hmac_desc))
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d7878..f4001f592911f 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4359,11 +4359,11 @@ static enum sctp_ierror sctp_sf_authenticate(
 					struct sctp_chunk *chunk)
 {
 	struct sctp_shared_key *sh_key = NULL;
 	struct sctp_authhdr *auth_hdr;
 	__u8 *save_digest, *digest;
-	struct sctp_hmac *hmac;
+	const struct sctp_hmac *hmac;
 	unsigned int sig_len;
 	__u16 key_id;
 
 	/* Pull in the auth header, so we can do some more verification */
 	auth_hdr = (struct sctp_authhdr *)chunk->skb->data;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 4921416434f9a..0292881a847ca 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9579,20 +9579,10 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	err = sctp_bind_addr_dup(&newsp->ep->base.bind_addr,
 				 &oldsp->ep->base.bind_addr, GFP_KERNEL);
 	if (err)
 		return err;
 
-	/* New ep's auth_hmacs should be set if old ep's is set, in case
-	 * that net->sctp.auth_enable has been changed to 0 by users and
-	 * new ep's auth_hmacs couldn't be set in sctp_endpoint_init().
-	 */
-	if (oldsp->ep->auth_hmacs) {
-		err = sctp_auth_init_hmacs(newsp->ep, GFP_KERNEL);
-		if (err)
-			return err;
-	}
-
 	sctp_auto_asconf_init(newsp);
 
 	/* Move any messages in the old socket's receive queue that are for the
 	 * peeled off association to the new socket's receive queue.
 	 */
-- 
2.50.1


