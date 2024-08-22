Return-Path: <linux-sctp+bounces-196-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92EA95B591
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83DB1C23276
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ADC1C9DFD;
	Thu, 22 Aug 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJhdhdUi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB431C9448;
	Thu, 22 Aug 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331470; cv=none; b=DqJiRDu7F7jLd/9AvsyGjKH3/3z0KBG3R4akDUltSKw04RCKeLl6nUc3pugk7Akud3MKRQhEbPIJGY+Sx5WcC3Q+A43N5eP/4v7qRO1nLDzlEgCn+3UtnjYEb3gGQSVOD1/jKdUEw3udbyh18QuUYM5mIOtPpz4xiv9ZZEV69QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331470; c=relaxed/simple;
	bh=RfMnoN83QYSzQG/5G/Ri5kUvD/SCmIdTg0pXZbH985s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLpNPQNfFXWOFhS5UJzYz5ytcOjuPJpNfiKQVz9PFWdO7VOcKmVpJN1khh/k/ZbcXKTBIvWrzSIyEXojsjtqtQOK+Vevos9hhZboLsSCYg+Ywc3x7uKr+E8HbAlYszU2ZDPmIGEDtBAc+m1zfxPmso8K02JVhSzDUMAPx4EhHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJhdhdUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DE4C4AF0C;
	Thu, 22 Aug 2024 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331470;
	bh=RfMnoN83QYSzQG/5G/Ri5kUvD/SCmIdTg0pXZbH985s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TJhdhdUi0Fct0qVhqIV9lQbSfv8okiRX99reNhxM5kaAaluYN2Q0dy2OGwRjxpHpT
	 FC4kNkpbqbBIiJZ34gk3Gen7PT7hfgRqt1d0z+aR244HPopimye5uT+5mplcGIk00U
	 65yPXABbjv2tAFqPmfh0kWWW+tPklt/Nz883Ba1ExDzpqqNjLw1I03yt84EFRMGdyl
	 9nR8Q0U0hlYH2IcXK41t+xWc+QZJ3yvIWfHhwg6N2gSQ+BnfCPyMvmOesKX4Tvtlnj
	 CdBIudhfBg3c3ssP31nkkB+4fs6C8qhEHdqBLw42XMlyAv83U1wc9rgvkDLNgCvPHh
	 mZ6wFQnT1epiQ==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:23 +0100
Subject: [PATCH net-next 02/13] s390/iucv: Correct spelling in iucv.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-2-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in iucv.h
As reported by codespell.

Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/iucv/iucv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/iucv/iucv.h b/include/net/iucv/iucv.h
index 4d114e6d6d23..dd9e93c12260 100644
--- a/include/net/iucv/iucv.h
+++ b/include/net/iucv/iucv.h
@@ -15,7 +15,7 @@
  * To explore any of the IUCV functions, one must first register their
  * program using iucv_register(). Once your program has successfully
  * completed a register, it can exploit the other functions.
- * For furthur reference on all IUCV functionality, refer to the
+ * For further reference on all IUCV functionality, refer to the
  * CP Programming Services book, also available on the web thru
  * www.vm.ibm.com/pubs, manual # SC24-6084
  *

-- 
2.43.0


