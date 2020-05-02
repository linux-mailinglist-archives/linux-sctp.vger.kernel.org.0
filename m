Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB11C2335
	for <lists+linux-sctp@lfdr.de>; Sat,  2 May 2020 07:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEBFd2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 2 May 2020 01:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgEBFd2 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sat, 2 May 2020 01:33:28 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D5D208DB;
        Sat,  2 May 2020 05:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397607;
        bh=MYhkXQ8M6ehjcKnUAHPgBXgoMFSmViXmlsVaKB/2/iE=;
        h=From:To:Cc:Subject:Date:From;
        b=EuFRJQF7AGrZKvzyKctf8/XBXbFdmS7XU+HXEDsVj1Uiclh02NaQ+LErt1Tlyg7nq
         wxqZntoSP2TMAzTR92QeFiKii2Pyrj26p5GQzuQv4F3MuyWA7XqVLcGGdg36Y16fux
         LWOXU+/+qXQZC3nDixS7relR/AF8g3aPbd7kM2D8=
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
Subject: [PATCH 00/20] crypto: introduce crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:02 -0700
Message-Id: <20200502053122.995648-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This series introduces a helper function crypto_shash_tfm_digest() which
replaces the following common pattern:

	{
		SHASH_DESC_ON_STACK(desc, tfm);
		int err;

		desc->tfm = tfm;

		err = crypto_shash_digest(desc, data, len, out);

		shash_desc_zero(desc);
	}

with:

	err = crypto_shash_tfm_digest(tfm, data, len, out);

Patch 1 introduces this helper function, and patches 2-20 convert all
relevant users to use it.

IMO, it would be easiest to take all these patches through the crypto
tree.  But taking just the "crypto:" ones and then me trying to get the
rest merged later via subsystem trees is also an option.

Eric Biggers (20):
  crypto: hash - introduce crypto_shash_tfm_digest()
  crypto: arm64/aes-glue - use crypto_shash_tfm_digest()
  crypto: essiv - use crypto_shash_tfm_digest()
  crypto: artpec6 - use crypto_shash_tfm_digest()
  crypto: ccp - use crypto_shash_tfm_digest()
  crypto: ccree - use crypto_shash_tfm_digest()
  crypto: hisilicon/sec2 - use crypto_shash_tfm_digest()
  crypto: mediatek - use crypto_shash_tfm_digest()
  crypto: n2 - use crypto_shash_tfm_digest()
  crypto: omap-sham - use crypto_shash_tfm_digest()
  crypto: s5p-sss - use crypto_shash_tfm_digest()
  nfc: s3fwrn5: use crypto_shash_tfm_digest()
  fscrypt: use crypto_shash_tfm_digest()
  ecryptfs: use crypto_shash_tfm_digest()
  nfsd: use crypto_shash_tfm_digest()
  ubifs: use crypto_shash_tfm_digest()
  Bluetooth: use crypto_shash_tfm_digest()
  sctp: use crypto_shash_tfm_digest()
  KEYS: encrypted: use crypto_shash_tfm_digest()
  ASoC: cros_ec_codec: use crypto_shash_tfm_digest()

 arch/arm64/crypto/aes-glue.c               |  4 +--
 crypto/essiv.c                             |  4 +--
 crypto/shash.c                             | 16 +++++++++
 drivers/crypto/axis/artpec6_crypto.c       | 10 ++----
 drivers/crypto/ccp/ccp-crypto-sha.c        |  9 ++---
 drivers/crypto/ccree/cc_cipher.c           |  9 ++---
 drivers/crypto/hisilicon/sec2/sec_crypto.c |  5 ++-
 drivers/crypto/mediatek/mtk-sha.c          |  7 ++--
 drivers/crypto/n2_core.c                   |  7 ++--
 drivers/crypto/omap-sham.c                 | 20 +++--------
 drivers/crypto/s5p-sss.c                   | 39 ++++------------------
 drivers/nfc/s3fwrn5/firmware.c             | 10 +-----
 fs/crypto/fname.c                          |  7 +---
 fs/crypto/hkdf.c                           |  6 +---
 fs/ecryptfs/crypto.c                       | 17 +---------
 fs/nfsd/nfs4recover.c                      | 26 ++++-----------
 fs/ubifs/auth.c                            | 20 ++---------
 fs/ubifs/master.c                          |  9 ++---
 fs/ubifs/replay.c                          | 14 ++------
 include/crypto/hash.h                      | 19 +++++++++++
 net/bluetooth/smp.c                        |  6 +---
 net/sctp/auth.c                            | 10 ++----
 net/sctp/sm_make_chunk.c                   | 23 +++++--------
 security/keys/encrypted-keys/encrypted.c   | 18 ++--------
 sound/soc/codecs/cros_ec_codec.c           |  9 +----
 25 files changed, 95 insertions(+), 229 deletions(-)

-- 
2.26.2

