Return-Path: <linux-sctp+bounces-201-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7E95B5A9
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03442857C0
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C01C9ED5;
	Thu, 22 Aug 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMjZ1P/E"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EAD1CB13A;
	Thu, 22 Aug 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331493; cv=none; b=pBpPupRjvmfXPhQ+TPZ/wJCvoh0X45OYt2M4rDOpoKEyP2NHzcNfgBXRQ+iMHyacxmSEerNfB2Kzhpigk1B2q6BFZmNGztqoO3jfiLXjlFsJDIR1LeQ7KQWWZbrJFks+h5AI2uXIayXfLIkpYrK9ekRcLG7LjSdwnhXWFWF8kGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331493; c=relaxed/simple;
	bh=KluiLPbgmkvpDmtfXvkcGmfgCPWUHv5loNG5U9w0TUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZW7uxMEvYKN8nFSz4Y9lgf8fzozwNHauxqiYgF2z7KkS46kvCVfcJy3pvKHfFAi1MVFuG+2CoFYXY7+jiZdZa/zwztMlBVIs2A8KTbQM9YVpN/EN/v0pTv/K7c+Fj+wK3ex1gJF3yYR37kQc99rtHr/MBsU6vE65stonVbKMqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMjZ1P/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1D3C32782;
	Thu, 22 Aug 2024 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331493;
	bh=KluiLPbgmkvpDmtfXvkcGmfgCPWUHv5loNG5U9w0TUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IMjZ1P/ED9gJirWs6BoFguB3nZDbzGBUeKdL6oHEy89eLwqXaFafqsla/CxZkEPyW
	 TemiZtFqBVMW6v1cYrJfJk7B8+Ebz0gzh3NWpGb573sphAeUODiIXEIMxScA8Xb2z+
	 m8+XFKsQXKuDoBcgO5oUrikoTNn9V7HQxAlmSNh43GDM75wPM+DpYMoigwfjGz2SZQ
	 cnoMbkYzICKvJj/SffQzHfGuZ3ozFdL74J8EkoqpwMM3AP7h3Ipourh5tFUNWXq/Bd
	 H0x3u+HLOYRY5GASx9nddaCKnyxztew4bRDKCYQuLuvLcqmxUUJ7CJLjsd0EWdgPF/
	 JPF0qW3vdFHkw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:28 +0100
Subject: [PATCH net-next 07/13] netlabel: Correct spelling in netlabel.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-7-3a98971ce2d2@kernel.org>
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

Correct spelling in netlabel.h.
As reported by codespell.

Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/netlabel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 654bc777d2a7..529160f76cac 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -30,7 +30,7 @@ struct calipso_doi;
 
 /*
  * NetLabel - A management interface for maintaining network packet label
- *            mapping tables for explicit packet labling protocols.
+ *            mapping tables for explicit packet labeling protocols.
  *
  * Network protocols such as CIPSO and RIPSO require a label translation layer
  * to convert the label on the packet into something meaningful on the host

-- 
2.43.0


