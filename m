Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D121C233A
	for <lists+linux-sctp@lfdr.de>; Sat,  2 May 2020 07:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEBFdc (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 2 May 2020 01:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgEBFdb (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sat, 2 May 2020 01:33:31 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40D182184D;
        Sat,  2 May 2020 05:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397610;
        bh=Xy09gJgOkkbJ0ZYrb6dZNClW7tkDv1nBUg2GeKdk1cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAXfGF92DERufghwz00F/QIgqNab18uegXgVsfl+gbihI7P/p7oBkSo2b7SRYemMo
         leI+9L+LpjxypzBwDoEDHo1kF1Vsv7aU4ikYmzDLr8A4ucNa1VtsvN0WpnFizpRcYI
         5y9cBCWx62jX8rIidTrAwvjSxsV+xDpN0LwZDndU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>, ecryptfs@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        keyrings@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Lars Persson <lars.persson@axis.com>,
        linux-bluetooth@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
        Robert Baldyga <r.baldyga@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: [PATCH 01/20] crypto: hash - introduce crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:03 -0700
Message-Id: <20200502053122.995648-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently the simplest use of the shash API is to use
crypto_shash_digest() to digest a whole buffer.  However, this still
requires allocating a hash descriptor (struct shash_desc).  Many users
don't really want to preallocate one and instead just use a one-off
descriptor on the stack like the following:

	{
		SHASH_DESC_ON_STACK(desc, tfm);
		int err;

		desc->tfm = tfm;

		err = crypto_shash_digest(desc, data, len, out);

		shash_desc_zero(desc);
	}

Wrap this in a new helper function crypto_shash_tfm_digest() that can be
used instead of the above.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/shash.c        | 16 ++++++++++++++++
 include/crypto/hash.h | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/crypto/shash.c b/crypto/shash.c
index c075b26c2a1d9f..e6a4b5f39b8c64 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -206,6 +206,22 @@ int crypto_shash_digest(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL_GPL(crypto_shash_digest);
 
+int crypto_shash_tfm_digest(struct crypto_shash *tfm, const u8 *data,
+			    unsigned int len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err;
+
+	desc->tfm = tfm;
+
+	err = crypto_shash_digest(desc, data, len, out);
+
+	shash_desc_zero(desc);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(crypto_shash_tfm_digest);
+
 static int shash_default_export(struct shash_desc *desc, void *out)
 {
 	memcpy(out, shash_desc_ctx(desc), crypto_shash_descsize(desc->tfm));
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index cee446c59497c6..4829d2367eda87 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -855,6 +855,25 @@ int crypto_shash_setkey(struct crypto_shash *tfm, const u8 *key,
 int crypto_shash_digest(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out);
 
+/**
+ * crypto_shash_tfm_digest() - calculate message digest for buffer
+ * @tfm: hash transformation object
+ * @data: see crypto_shash_update()
+ * @len: see crypto_shash_update()
+ * @out: see crypto_shash_final()
+ *
+ * This is a simplified version of crypto_shash_digest() for users who don't
+ * want to allocate their own hash descriptor (shash_desc).  Instead,
+ * crypto_shash_tfm_digest() takes a hash transformation object (crypto_shash)
+ * directly, and it allocates a hash descriptor on the stack internally.
+ * Note that this stack allocation may be fairly large.
+ *
+ * Context: Any context.
+ * Return: 0 on success; < 0 if an error occurred.
+ */
+int crypto_shash_tfm_digest(struct crypto_shash *tfm, const u8 *data,
+			    unsigned int len, u8 *out);
+
 /**
  * crypto_shash_export() - extract operational state for message digest
  * @desc: reference to the operational state handle whose state is exported
-- 
2.26.2

